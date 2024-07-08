import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/send_push_notification.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

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

  Future<void> addToLikedList(
    String toUserId,
    String currentUserId,
    WidgetRef ref,
    BuildContext context,
  ) async {
    final currentUserDoc = _store.collection('users').doc(currentUserId);
    final toUserDoc = _store.collection('users').doc(toUserId);

    try {
      // Adding users to each other's liked list
      await currentUserDoc.collection('likedList').doc(toUserId).set({});
      await toUserDoc.collection('likesYouList').doc(currentUserId).set({});

      // Check if there's a mutual like
      final mutualLike =
          await toUserDoc.collection('likedList').doc(currentUserId).get();

      if (mutualLike.exists) {
        // Add users to each other's matched list
        await currentUserDoc.collection('matchedList').doc(toUserId).set({});
        await toUserDoc.collection('matchedList').doc(currentUserId).set({});

        // Create a new chat room for the match
        final userIds = [toUserId, currentUserId]..sort();
        await _store.collection('rooms').add({
          'createdAt': FieldValue.serverTimestamp(),
          'imageUrl': null,
          'name': null,
          'type': types.RoomType.direct.toShortString(),
          'updatedAt': FieldValue.serverTimestamp(),
          'userIds': userIds,
          'userRoles': null,
        });

        // Send match notifications
        await sendMatchNotification(currentUserId, toUserId);
        await sendMatchNotification(toUserId, currentUserId);
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  color: const Color(0xff200F3A),
                  height: 600,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'You have a new match!',
                        style: S.textStyles.font16White,
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () => context.maybePop(),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        child: AsyncWidget<UserModel>(
                          data: ref.watch(userProviderWithID(currentUserId)),
                          builder: (userData) {
                            return CustomImage.network(
                              userData.profileImages.first,
                              fit: BoxFit.cover,
                              height: 100,
                              memCacheHeight: 200,
                              borderRadius: S.borderRadius.radius50,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        right: 20,
                        child: AsyncWidget<UserModel>(
                          data: ref.watch(userProviderWithID(toUserId)),
                          builder: (userData) {
                            return CustomImage.network(
                              userData.profileImages.first,
                              borderRadius: S.borderRadius.radius50,
                              fit: BoxFit.cover,
                              height: 100,
                              memCacheHeight: 200,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        child: IconButton(
                          icon: const Icon(
                            Icons.message,
                            color: Colors.white,
                            size: 50,
                          ),
                          onPressed: () async {
                            final roomId =
                                await getRoomId(currentUserId, toUserId);
                            final user =
                                ref.watch(getUserStreamWithId(toUserId));
                            if (roomId != null) {
                              final room = types.Room(
                                type: types.RoomType.direct,
                                id: roomId,
                                name:
                                    '${user.value?.firstName} ${user.value?.lastName}',
                                users: [
                                  types.User(id: currentUserId),
                                  types.User(id: toUserId)
                                ],
                              );

                              if (context.mounted) {
                                context.router.push(ChatRoute(roomId: room.id));
                              }
                            } else {
                              if (context.mounted) {
                                Utils.show
                                    .toast(context, "Chat room can't be found");
                              }
                            }
                          },
                        ),
                      ),
                      Lottie.asset(
                        R.anims.matchingHearts,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }
    } catch (e) {
      Future.error("Error adding to liked list: $e");
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
        Print.error(doc.id);
        return doc.id;
      }
    }

    return null;
  }

  Future<types.Room?> getRoom(String userId1, String userId2) async {
    final roomSnapshot = await FirebaseFirestore.instance
        .collection('rooms')
        .where('userIds', arrayContains: userId1)
        .get();

    for (var doc in roomSnapshot.docs) {
      List users = doc['userIds'];
      if (users.contains(userId2)) {
        Print.error(doc.data());

        final data = doc.data();

        final createdAt =
            (data['createdAt'] as Timestamp?)?.millisecondsSinceEpoch ?? 0;
        final updatedAt =
            (data['updatedAt'] as Timestamp?)?.millisecondsSinceEpoch ?? 0;
        final userRoles = data['userRoles'] as String? ?? '';
        final userIds =
            (data['userIds'] as List<dynamic>?)?.cast<String>() ?? [];
        final imageUrl = data['imageUrl'] as String? ?? '';
        final name = data['name'] as String? ?? '';
        final type = data['type'] as String? ?? '';
        final lastMessages = data['lastMessages'] as List<dynamic>? ?? [];
        final metaData = data['metaData'] as Map<String, dynamic>? ?? {};

        Print.error('createdAt: $createdAt (${createdAt.runtimeType})');
        Print.error('updatedAt: $updatedAt (${updatedAt.runtimeType})');
        Print.error('userRoles: $userRoles (${userRoles.runtimeType})');
        Print.error('userIds: $userIds (${userIds.runtimeType})');
        Print.error('imageUrl: $imageUrl (${imageUrl.runtimeType})');
        Print.error('name: $name (${name.runtimeType})');
        Print.error('type: $type (${type.runtimeType})');
        Print.error(
            'lastMessages: $lastMessages (${lastMessages.runtimeType})');
        Print.error('metaData: $metaData (${metaData.runtimeType})');

        final handleData = {
          'id': doc.id,
          'createdAt': createdAt,
          'updatedAt': updatedAt,
          'userRoles': userRoles,
          'userIds': userIds,
          'imageUrl': imageUrl,
          'name': name,
          'type': type,
          'lastMessages': lastMessages,
          'metaData': metaData,
        };

        Print.error('handleData: $handleData (${handleData.runtimeType})');

        try {
          final room = types.Room.fromJson(handleData);
          Print.error('Room created successfully');
          return room;
        } catch (e) {
          Print.error('Error creating Room: $e');
        }
      }
    }

    return null;
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
