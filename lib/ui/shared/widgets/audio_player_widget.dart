import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AudioPlayerWidget extends HookConsumerWidget {
  final types.AudioMessage message;
  final int messageWidth;

  const AudioPlayerWidget({
    required this.message,
    required this.messageWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = useMemoized(() => FlutterSoundPlayer());
    final isPlaying = useState(false);
    final position = useState(Duration.zero);
    final duration =
        useState(Duration(milliseconds: message.duration.inMilliseconds));
    final isPlayerInitialized = useState(false);
    useEffect(() {
      void initializePlayer() async {
        await player.openPlayer();
        player.setSubscriptionDuration(const Duration(milliseconds: 100));
        player.onProgress!.listen((event) {
          position.value = event.position;
          if (!isPlayerInitialized.value) {
            duration.value = event.duration;
            isPlayerInitialized.value = true;
          }
        });
      }

      initializePlayer();

      return () {
        player.closePlayer();
      };
    }, []);

    Future<void> togglePlayPause() async {
      if (isPlaying.value) {
        await player.pausePlayer();
      } else {
        if (position.value < duration.value &&
            position.value != Duration.zero) {
          await player.resumePlayer();
        } else {
          await player.startPlayer(
            fromURI: message.uri,
            whenFinished: () {
              isPlaying.value = false;
              position.value = Duration.zero;
            },
          );
        }

        if (position.value > Duration.zero) {
          await player.seekToPlayer(position.value);
        }
      }
      isPlaying.value = !isPlaying.value;
    }

    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return '$minutes:$seconds';
    }

    return Container(
      width: messageWidth.toDouble(),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.audio,
            style: S.textStyles.font16White,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: togglePlayPause,
              ),
              Expanded(
                child: Slider(
                  min: 0.0,
                  max: duration.value.inMilliseconds.toDouble(),
                  value: position.value.inMilliseconds.toDouble(),
                  inactiveColor: Colors.white,
                  activeColor: Colors.teal,
                  onChanged: (value) async {
                    final newPosition = Duration(milliseconds: value.toInt());
                    position.value = newPosition;
                    await player.seekToPlayer(newPosition);
                  },
                ),
              ),
              Text(
                '${formatDuration(position.value)} / ${formatDuration(duration.value)}',
                style: S.textStyles.font16White,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
