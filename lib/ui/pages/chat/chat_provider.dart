import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

@riverpod
Stream<types.Room> room(RoomRef ref, String roomId) {
  return FirebaseChatCore.instance.room(roomId);
}

@riverpod
Stream<List<types.Message>> messages(MessagesRef ref, types.Room room) {
  return FirebaseChatCore.instance.messages(room);
}
