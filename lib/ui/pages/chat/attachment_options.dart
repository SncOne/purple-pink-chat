import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/pages/chat/chat_audio_dialog.dart';
import 'package:catt_catt/ui/pages/chat/functions.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AttachmentOptions extends HookConsumerWidget {
  final String roomId;
  final String otherUserId;

  const AttachmentOptions(
      {required this.roomId, required this.otherUserId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AttachmentButton(
              icon: Icons.image,
              text: t.photo,
              onPressed: () {
                context.maybePop();
                handleImageSelection(ref, context, otherUserId, roomId);
              },
            ),
            AttachmentButton(
              icon: Icons.video_camera_back_outlined,
              text: t.video,
              onPressed: () {
                context.maybePop();
                handleVideoSelection(ref, context, otherUserId, roomId);
              },
            ),
            AttachmentButton(
              icon: Icons.audiotrack_outlined,
              text: t.audio,
              onPressed: () {
                context.maybePop();
                handleAudioSelection(ref, context, otherUserId, roomId);
              },
            ),
            TextButton(
              onPressed: () => context.maybePop(),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(t.cancel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttachmentButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const AttachmentButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xff200F3A),
            ),
            S.sizedBox.w12,
            Text(text),
          ],
        ),
      ),
    );
  }
}
