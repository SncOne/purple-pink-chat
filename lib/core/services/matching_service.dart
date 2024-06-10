import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final matchingService = Provider.autoDispose((_) => MatchingService());

class MatchingService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _store => FirebaseFirestore.instance;
  FirebaseStorage get _storage => FirebaseStorage.instance;

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

  Future addToLikedList(userId, currentUserId) async {
    await _store
        .collection('users')
        .doc(currentUserId)
        .collection('likedList')
        .add(userId);
    await _store
        .collection('users')
        .doc(userId)
        .collection('likesYouList')
        .add(currentUserId);
  }
}
