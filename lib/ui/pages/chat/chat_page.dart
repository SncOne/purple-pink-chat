import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class ChatPage extends HookConsumerWidget {
  final types.Room room;
  const ChatPage({required this.room, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleImageSelection() async {
      final result = await ImagePicker().pickMultiImage(
        imageQuality: 70,
        maxWidth: 1440,
        limit: 4,
      );

      if (result != null) {
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
            print("Error uploading image: $e");
            // Handle the error as per your requirement
          }
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
        final bytes = await result.readAsBytes();
        final video = await decodeImageFromList(bytes);
        final name = result.name;

        try {
          final reference = FirebaseStorage.instance.ref(name);
          await reference.putFile(file);
          final uri = await reference.getDownloadURL();

          final message = types.PartialVideo(
            height: video.height.toDouble(),
            name: name,
            size: size,
            uri: uri,
            width: video.width.toDouble(),
          );

          FirebaseChatCore.instance.sendMessage(
            message,
            room.id,
          );
        } finally {}
      }
    }

    void handleAudioSelection() async {
      final audioRecorder = FlutterSound();
      final encoder = Codec.aacMP4;

      // try {
      //   // Start recording audio
      //   String path = await audioRecorder.startRecorder(
      //     codec: encoder,
      //     sampleRate: 44100,
      //     bitRate: 128000,
      //   );

      //   // You may want to have a UI to indicate recording is in progress

      //   // Here you would typically have some UI to stop recording
      //   // For example, have a button to stop recording and call:
      //   // await audioRecorder.stopRecorder();

      //   final file = File(path);
      //   final size = file.lengthSync();
      //   final name = DateTime.now().millisecondsSinceEpoch.toString();

      //   // Upload audio file to Firebase Storage
      //   final reference = FirebaseStorage.instance.ref('audios/$name.mp4');
      //   await reference.putFile(file);
      //   final uri = await reference.getDownloadURL();

      //   // Create a message object
      //   final message = types.PartialAudio(
      //     duration: Duration(seconds: 15), // Duration of the audio
      //     name: name, // Name of the audio file
      //     size: size, // Size of the audio file
      //     uri: uri, // Download URL of the audio file
      //   );

      //   // Send the message
      //   FirebaseChatCore.instance.sendMessage(
      //     message,
      //     room.id,
      //   );
      // } catch (e) {
      //   print("Error: $e");
      //   // Handle error, maybe show a snackbar or dialog
      // }
    }

    void handleAtachmentPressed() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => SafeArea(
          child: SizedBox(
            height: 144,
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
            onAttachmentPressed: handleAtachmentPressed,
            onPreviewDataFetched: handlePreviewDataFetched,
            onSendPressed: handleSendPressed,
            user: types.User(
              id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
