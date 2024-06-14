import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messagesService = Provider((_) => MessagesService());

class MessagesService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _store => FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  //Delete Message
  Future<void> deleteMessage(String roomId, String messageId) async {
    await _store.collection('rooms/$roomId/messages').doc(messageId).delete();
  }

  /// Removes room document.
  Future<void> deleteRoom(String roomId) async {
    await _store.collection("rooms").doc(roomId).delete();
  }

  // Stream<List<MessagesModel>> getMessages({
  //   required String roomId,
  //   List<Object?>? endAt,
  //   List<Object?>? endBefore,
  //   int? limit,
  //   List<Object?>? startAfter,
  //   List<Object?>? startAt,
  // }) {
  //   var query = _store
  //       .collection('rooms/$roomId/messages')
  //       .orderBy('createdAt', descending: true);

  //   if (endAt != null) {
  //     query = query.endAt(endAt);
  //   }

  //   if (endBefore != null) {
  //     query = query.endBefore(endBefore);
  //   }

  //   if (limit != null) {
  //     query = query.limit(limit);
  //   }

  //   if (startAfter != null) {
  //     query = query.startAfter(startAfter);
  //   }

  //   if (startAt != null) {
  //     query = query.startAt(startAt);
  //   }

  //   return query.snapshots().map(
  //         (snapshot) => snapshot.docs.fold<List<MessagesModel>>(
  //           [],
  //           (previousValue, doc) {
  //             final data = doc.data();
  //             final author = room.users.firstWhere(
  //               (u) => u.id == data['authorId'],
  //               orElse: () => UserModel(uid: data['authorId'] as String),
  //             );

  //             data['author'] = author.toJson();
  //             data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
  //             data['id'] = doc.id;
  //             data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

  //             return [...previousValue, MessagesModel.fromJson(data)];
  //           },
  //         ),
  //       );
  // }
}
