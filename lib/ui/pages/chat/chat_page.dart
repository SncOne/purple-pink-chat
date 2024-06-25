import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/storage_service.dart';
import 'package:catt_catt/ui/pages/chat/chat_app_bar.dart';
import 'package:catt_catt/ui/pages/chat/chat_body.dart';
import 'package:catt_catt/ui/pages/chat/chat_provider.dart';
import 'package:catt_catt/ui/pages/messages/messages_provider.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

@RoutePage()
class ChatPage extends HookConsumerWidget {
  final types.Room room;
  const ChatPage({required this.room, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() {
        ref.read(storageService).setLastSeenDateTime(room.id, DateTime.now());
        ref.invalidate(unreadMessageCountProvider(room.id));
      });
      return null;
    }, const []);

    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        ref.read(storageService).setLastSeenDateTime(room.id, DateTime.now());
        ref.invalidate(unreadMessageCountProvider(room.id));
      },
      child: Scaffold(
        appBar: ChatAppBar(
            otherUserId: room.users
                .firstWhere((u) => u.id != ref.read(authService).user!.uid)
                .id,
            roomName: room.name.toString()),
        body: AsyncWidget(
          data: ref.watch(roomProvider(room.id)),
          builder: (roomData) => ChatBody(room: room, roomData: roomData),
        ),
      ),
    );
  }
}
