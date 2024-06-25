import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/messages_service.dart';
import 'package:catt_catt/ui/pages/chat/attachment_options.dart';
import 'package:catt_catt/ui/pages/chat/chat_provider.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/audio_player_widget.dart';
import 'package:catt_catt/ui/shared/widgets/video_player_widget.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatBody extends HookConsumerWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(selectedRoomProvider)!;

    final currentUser = ref.read(authService).user;
    final otherUser = room.users.firstWhere(
      (u) => u.id != currentUser!.uid,
    );

    Print.info('ehe');
    void handleAttachmentPressed() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => AttachmentOptions(
          roomId: room.id,
          otherUserId: otherUser.id,
        ),
      );
    }

    return AsyncWidget<List<types.Message>>(
      data: ref.watch(messagesProvider(room)),
      builder: (chatData) {
        Print.info('eeee');
        return Chat(
          showUserAvatars: true,
          messages: chatData,
          onAttachmentPressed: handleAttachmentPressed,
          usePreviewData: true,
          showUserNames: true,
          onPreviewDataFetched: (message, previewData) {
            final updatedMessage = message.copyWith(previewData: previewData);
            FirebaseChatCore.instance.updateMessage(updatedMessage, room.id);
          },
          onSendPressed: (message) {
            ref
                .read(messagesService)
                .sendMessage(message, room.id, otherUser.id);
          },
          user:
              types.User(id: FirebaseChatCore.instance.firebaseUser?.uid ?? ''),
          audioMessageBuilder: (audioMessage, {required messageWidth}) {
            return AudioPlayerWidget(
              message: audioMessage,
              messageWidth: messageWidth,
            );
          },
          videoMessageBuilder: (videoMessage, {required messageWidth}) {
            return VideoPlayerWidget(
              message: videoMessage,
              messageWidth: messageWidth,
            );
          },
        );
      },
    );
  }
}
