import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/storage_service.dart';
import 'package:catt_catt/ui/pages/chat/chat_app_bar.dart';
import 'package:catt_catt/ui/pages/chat/chat_body.dart';
import 'package:catt_catt/ui/pages/chat/chat_provider.dart';
import 'package:catt_catt/ui/pages/messages/messages_provider.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ChatPage extends HookConsumerWidget {
  final String roomId;
  const ChatPage({@pathParam required this.roomId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(selectedRoomProvider)!;

    useEffect(() {
      Future.microtask(() {
        ref.read(storageService).setLastSeenDateTime(roomId, DateTime.now());
        ref.invalidate(unreadMessageCountProvider(roomId));
      });
      return null;
    }, const []);

    Print.error('ehe');

    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        ref.read(storageService).setLastSeenDateTime(roomId, DateTime.now());
        ref.invalidate(unreadMessageCountProvider(roomId));
      },
      child: Scaffold(
        appBar: ChatAppBar(
          otherUserId: room.users
              .firstWhere((u) => u.id != ref.read(authService).user!.uid)
              .id,
          roomName: room.name.toString(),
        ),
        body: const ChatBody(),
      ),
    );
  }
}
