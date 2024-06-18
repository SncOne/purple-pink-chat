import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/services/send_push_notification.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final matchingService = Provider((_) => MatchingService());

class MatchingService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _store => FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  Stream<QuerySnapshot> getMatchedList(userId) {
    return _store
        .collection('users')
        .doc(userId)
        .collection('matchedList')
        .snapshots();
  }

  Stream<QuerySnapshot> getLikedList(userId) {
    return _store
        .collection('users')
        .doc(userId)
        .collection('likedList')
        .snapshots();
  }

  Stream<QuerySnapshot> getLikesYouList(userId) {
    return _store
        .collection('users')
        .doc(userId)
        .collection('likesYouList')
        .snapshots();
  }

  Future<void> addToLikedList(String toUserId, String currentUserId) async {
    final currentUserDoc = _store.collection('users').doc(currentUserId);
    final toUserDoc = _store.collection('users').doc(toUserId);

    currentUserDoc.collection('likedList').doc(toUserId).set({});
    toUserDoc.collection('likesYouList').doc(currentUserId).set({});

    final mutualLike =
        await toUserDoc.collection('likedList').doc(currentUserId).get();

    if (mutualLike.exists) {
      currentUserDoc.collection('matchedList').doc(toUserId).set({});
      toUserDoc.collection('matchedList').doc(currentUserId).set({});
      final userIds = [toUserId, currentUserId]..sort();
      _store.collection('rooms').add({
        'createdAt': FieldValue.serverTimestamp(),
        'imageUrl': null,
        'name': null,
        'type': types.RoomType.direct.toShortString(),
        'updatedAt': FieldValue.serverTimestamp(),
        'userIds': userIds,
        'userRoles': null,
      });
      sendMatchNotification(currentUserId, toUserId);
      sendMatchNotification(toUserId, currentUserId);
      //TODO: show PopUp for matching on the user screen
    }
  }

  Future<UserModel> getUserProfile(String userId) async {
    final userProfiles = await _store.collection('users').doc(userId).get();
    final data = userProfiles.data();
    if (data != null) {
      return UserModel.fromJson(data);
    } else {
      throw Future.error('User profile not found');
    }
  }

  Future<String?> getRoomId(String userId1, String userId2) async {
    final roomSnapshot = await FirebaseFirestore.instance
        .collection('rooms')
        .where('userIds', arrayContains: userId1)
        .get();

    for (var doc in roomSnapshot.docs) {
      List users = doc['userIds'];
      if (users.contains(userId2)) {
        return doc.id;
      }
    }

    return null; // Eğer oda bulunamazsa
  }

  Future<void> sendMatchNotification(
      String toUserId, String matchedUserId) async {
    final toUser = await getUserProfile(toUserId);
    final matchedUser = await getUserProfile(matchedUserId);

    await _store.collection('notifications').add({
      'toUserId': toUser.uid,
      'message': 'You have matched with ${matchedUser.firstName}!',
      'timestamp': FieldValue.serverTimestamp(),
    });

    final tokenSnapshot = await _store.collection('users').doc(toUserId).get();
    Print.warning(tokenSnapshot.data(), "here");
    final token = tokenSnapshot.data()?['fcmToken'] as String?;
    Print.warning(token, "here2");
    if (token != null) {
      Print.error(token);
      await sendPushNotification(
        deviceToken: token,
        title: 'New Match!',
        body: 'You have matched with ${matchedUser.firstName}!',
      );
    }
  }
}
