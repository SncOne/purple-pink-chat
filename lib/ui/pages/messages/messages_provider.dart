import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/storage_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_provider.g.dart';

@riverpod
Stream<List<Room>> messages(MessagesRef ref) {
  return FirebaseChatCore.instance.rooms();
}

@riverpod
Stream<int> unreadMessageCount(UnreadMessageCountRef ref, String roomId) {
  final lastSeenDate = ref.read(storageService).getLastSeenDateTime(roomId);
  final currentUser = ref.read(authService).user;
  var count = 0;
  var lastMessageId = '';
  return FirebaseChatCore.instance
      .messages(types.Room(
    id: roomId,
    type: types.RoomType.direct,
    users: [types.User(id: currentUser!.uid)],
  ))
      .map((messages) {
    if (messages.isNotEmpty) {
      final latestMessage = messages.first;
      if (lastSeenDate < latestMessage.createdAt!) {
        if (latestMessage.author.id != currentUser.uid) {
          if (lastMessageId != latestMessage.id) {
            count++;
            lastMessageId = latestMessage.id;
          }
        }
      }
    }
    return count;
  });
}
