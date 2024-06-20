import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AudioPlayerWidget extends HookConsumerWidget {
  final types.AudioMessage message;
  final int messageWidth;
  const AudioPlayerWidget(
      {required this.message, required this.messageWidth, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = FlutterSoundPlayer();
    return HookBuilder(
      builder: (context) {
        final isPlaying = useState(false);
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Audio message: ${message.name}'),
              Text('Duration: ${message.duration} seconds'),
              IconButton(
                icon: Icon(isPlaying.value ? Icons.stop : Icons.play_arrow),
                onPressed: () async {
                  await player.openPlayer();
                  if (isPlaying.value) {
                    await player.stopPlayer();
                  } else {
                    await player.startPlayer(
                      fromURI: message.uri,
                      whenFinished: () {
                        isPlaying.value = false;
                      },
                    );
                  }
                  isPlaying.value = !isPlaying.value;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
