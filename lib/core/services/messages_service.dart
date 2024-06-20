import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

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

  void sendMessage(dynamic partialMessage, String roomId) async {
    if (user == null) return;

    types.Message? message;

    if (partialMessage is types.PartialCustom) {
      message = types.CustomMessage.fromPartial(
        author: types.User(id: user!.uid),
        id: '',
        partialCustom: partialMessage,
      );
    } else if (partialMessage is types.PartialFile) {
      message = types.FileMessage.fromPartial(
        author: types.User(id: user!.uid),
        id: '',
        partialFile: partialMessage,
      );
    } else if (partialMessage is types.PartialImage) {
      message = types.ImageMessage.fromPartial(
        author: types.User(id: user!.uid),
        id: '',
        partialImage: partialMessage,
      );
    } else if (partialMessage is types.PartialText) {
      message = types.TextMessage.fromPartial(
        author: types.User(id: user!.uid),
        id: '',
        partialText: partialMessage,
      );
    } else if (partialMessage is types.PartialAudio) {
      message = types.AudioMessage.fromPartial(
        author: types.User(id: user!.uid),
        id: '',
        partialAudio: partialMessage,
      );
    } else if (partialMessage is types.PartialVideo) {
      message = types.VideoMessage.fromPartial(
        author: types.User(id: user!.uid),
        id: '',
        partialVideo: partialMessage,
      );
    }

    if (message != null) {
      final messageMap = message.toJson();
      messageMap.removeWhere((key, value) => key == 'author' || key == 'id');
      messageMap['authorId'] = user!.uid;
      messageMap['createdAt'] = FieldValue.serverTimestamp();
      messageMap['updatedAt'] = FieldValue.serverTimestamp();

      await _store.collection('rooms/$roomId/messages').add(messageMap);

      await _store
          .collection("rooms")
          .doc(roomId)
          .update({'updatedAt': FieldValue.serverTimestamp()});
    }
  }
}
