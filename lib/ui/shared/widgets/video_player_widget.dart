import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends HookConsumerWidget {
  final types.VideoMessage message;
  final int messageWidth;
  const VideoPlayerWidget(
      {required this.message, required this.messageWidth, super.key});

  VideoPlayerController useVideoPlayerController(String uri,
      {bool isMuted = true}) {
    return useMemoized(() {
      VideoPlayerController controller;
      if (uri.startsWith('http')) {
        Print.error('network');
        controller = VideoPlayerController.networkUrl(Uri.parse(uri));
      } else {
        Print.error('file');
        controller = VideoPlayerController.file(File(uri));
      }
      if (isMuted) {
        controller.setVolume(0.0);
        controller.setLooping(true);
      }
      return controller;
    }, [uri, isMuted]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useVideoPlayerController(message.uri);

    return HookBuilder(
      builder: (context) {
        final isInitialized = useState(false);

        useEffect(() {
          controller.initialize().then((_) {
            isInitialized.value = true;
            controller.play(); // Sessiz önizleme için oynat
          });
          return () {
            controller.dispose();
          };
        }, [controller]);

        return isInitialized.value
            ? GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        _FullScreenVideoPlayer(message: message),
                  );
                },
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(controller),
                      const Positioned(
                        top: 10,
                        left: 10,
                        child: Icon(
                          Icons.volume_mute_sharp,
                          color: Colors.white,
                        ),
                      ),
                      VideoProgressIndicator(
                        controller,
                        allowScrubbing: false,
                        colors: const VideoProgressColors(
                          playedColor: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 200,
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}

class _FullScreenVideoPlayer extends HookWidget {
  final types.VideoMessage message;
  const _FullScreenVideoPlayer({required this.message});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() {
      VideoPlayerController ctrl;
      if (message.uri.startsWith('http')) {
        ctrl = VideoPlayerController.networkUrl(Uri.parse(message.uri));
      } else {
        ctrl = VideoPlayerController.file(File(message.uri));
      }
      ctrl.setVolume(1.0); // Sesli oynatma
      return ctrl;
    }, [message.uri]);

    final isInitialized = useState(false);

    useEffect(() {
      controller.initialize().then((_) {
        isInitialized.value = true;
        controller.play();
      });
      return () {
        controller.dispose();
      };
    }, [controller]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: isInitialized.value
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(controller),
                    _ControlsOverlay(controller: controller),
                    VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Colors.deepPurple,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white, size: 30),
                        onPressed: () {
                          context.maybePop();
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class _ControlsOverlay extends HookWidget {
  final VideoPlayerController controller;
  const _ControlsOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(!controller.value.isPlaying);

    useEffect(() {
      listener() {
        isVisible.value = !controller.value.isPlaying;
      }

      controller.addListener(listener);
      return () {
        controller.removeListener(listener);
      };
    }, [controller]);

    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: isVisible.value
              ? ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}
