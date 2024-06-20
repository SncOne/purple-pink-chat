import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/messages_service.dart';
import 'package:catt_catt/ui/shared/widgets/audio_player_widget.dart';
import 'package:catt_catt/ui/shared/widgets/video_player_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

@RoutePage()
class ChatPage extends HookConsumerWidget {
  final types.Room room;
  const ChatPage({required this.room, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterSoundRecorder? audioRecorder;
    final isRecording = useState(false);

    final messageServiceProvider = ref.watch(messagesService);

    Future<void> startRecording() async {
      audioRecorder = FlutterSoundRecorder();
      await audioRecorder!.openRecorder();
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }

      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

      try {
        await audioRecorder!.startRecorder(toFile: path);
        isRecording.value = true;
      } catch (e) {
        Future.error("Error: $e");
      }
    }

    Future<String?> stopRecording() async {
      if (audioRecorder != null && audioRecorder!.isRecording) {
        final uri = await audioRecorder!.stopRecorder();
        isRecording.value = false;
        return uri;
      }
      return null;
    }

    void handleImageSelection() async {
      final result = await ImagePicker().pickMultiImage(
        imageQuality: 70,
        maxWidth: 1440,
        limit: 4,
      );

      for (var element in result) {
        final file = File(element.path);
        final size = file.lengthSync();
        final bytes = await element.readAsBytes();
        final image = await decodeImageFromList(bytes);
        final name = element.name;

        try {
          final reference = FirebaseStorage.instance.ref(name);
          await reference.putFile(file);
          final uri = await reference.getDownloadURL();

          final message = types.PartialImage(
            height: image.height.toDouble(),
            name: name,
            size: size,
            uri: uri,
            width: image.width.toDouble(),
          );

          FirebaseChatCore.instance.sendMessage(
            message,
            room.id,
          );
        } catch (e) {
          Future.error("Error uploading image: $e");
        }
      }
    }

    void handleVideoSelection() async {
      final result = await ImagePicker().pickVideo(
        maxDuration: const Duration(minutes: 2),
        source: ImageSource.gallery,
      );

      if (result != null) {
        final file = File(result.path);
        final size = file.lengthSync();
        final name = result.name;

        try {
          final reference = FirebaseStorage.instance.ref(name);
          await reference.putFile(file);
          final uri = await reference.getDownloadURL();

          final message = types.PartialVideo(
            height: 0,
            name: name,
            size: size,
            uri: uri,
            width: 0,
          );

          messageServiceProvider.sendMessage(
            message,
            room.id,
          );
        } catch (e) {
          Future.error("Error uploading video: $e");
        }
      }
    }

    void handleAudioSelection() async {
      await startRecording();

      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Recording...'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  const Text('Recording in progress...'),
                  TextButton(
                    onPressed: () async {
                      final uri = await stopRecording();
                      if (uri != null) {
                        final file = File(uri);
                        final size = file.lengthSync();
                        final duration = DateTime.now().millisecondsSinceEpoch;
                        final name =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        final reference =
                            FirebaseStorage.instance.ref('$name.aac');
                        await reference.putFile(file);
                        final downloadUri = await reference.getDownloadURL();

                        final message = types.PartialAudio(
                          duration: Duration(milliseconds: duration),
                          name: name,
                          size: size,
                          uri: downloadUri,
                        );

                        messageServiceProvider.sendMessage(
                          message,
                          room.id,
                        );
                      }
                      if (context.mounted) {
                        context.maybePop();
                      }
                    },
                    child: const Text('Stop Recording'),
                  ),
                ],
              ),
            );
          },
        );
      }
    }

    void handleAttachmentPressed() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => SafeArea(
          child: SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    handleVideoSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Video'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    handleAudioSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Audio'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
    ) {
      final updatedMessage = message.copyWith(previewData: previewData);

      FirebaseChatCore.instance.updateMessage(updatedMessage, room.id);
    }

    void handleSendPressed(types.PartialText message) {
      FirebaseChatCore.instance.sendMessage(
        message,
        room.id,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(room.name.toString()),
      ),
      body: StreamBuilder<types.Room>(
        initialData: room,
        stream: FirebaseChatCore.instance.room(room.id),
        builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
          initialData: const [],
          stream: FirebaseChatCore.instance.messages(snapshot.data!),
          builder: (context, snapshot) => Chat(
            messages: snapshot.data ?? [],
            onAttachmentPressed: handleAttachmentPressed,
            onPreviewDataFetched: handlePreviewDataFetched,
            onSendPressed: handleSendPressed,
            user: types.User(
              id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
            ),
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
          ),
        ),
      ),
    );
  }
}
