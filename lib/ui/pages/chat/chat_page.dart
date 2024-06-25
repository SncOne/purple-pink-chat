import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/messages_service.dart';
import 'package:catt_catt/core/services/send_push_notification.dart';
import 'package:catt_catt/core/services/storage_service.dart';
import 'package:catt_catt/ui/pages/messages/messages_provider.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/audio_player_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/ui/shared/widgets/video_player_widget.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

    FlutterSoundRecorder? audioRecorder;
    final isRecording = useState(false);

    final messageServiceProvider = ref.watch(messagesService);
    final currentUser = ref.read(authService).user;

    final otherUser = room.users.firstWhere(
      (u) => u.id != currentUser!.uid,
    );
    Future<void> startRecording() async {
      audioRecorder = FlutterSoundRecorder();
      await audioRecorder!.openRecorder();
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException(t.microphonePermissionNotGranted);
      }

      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

      try {
        await audioRecorder!.startRecorder(toFile: path);
        isRecording.value = true;
      } catch (e) {
        Future.error("${t.error}: $e");
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
      final otherUserProfile =
          await ref.watch(userProviderWithID(otherUser.id).future);
      final currentUserProfile =
          await ref.watch(userProviderWithID(currentUser!.uid).future);
      if (otherUserProfile.canRecieveImages) {
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

            messageServiceProvider.sendMessage(
              message,
              room.id,
              otherUser.id,
            );
          } catch (e) {
            Future.error("${t.errorUploadingImage}: $e");
          }
        }
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(t.cantSendImage),
                content: Text(t.userCantRecieveImages),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      context.maybePop();
                    },
                    child: Text(t.ok),
                  ),
                  TextButton(
                    onPressed: () async {
                      final tokenSnapshot = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(otherUser.id)
                          .get();
                      final token =
                          tokenSnapshot.data()?['fcmToken'] as String?;
                      if (token != null) {
                        await sendPushNotification(
                          deviceToken: token,
                          title: t.recieveImageTitle,
                          body: t.recieveImageBody(
                              firstName: currentUserProfile.firstName),
                        );
                      }
                      if (context.mounted) {
                        Utils.show.toast(context, t.requestSended);
                        context.maybePop();
                      }
                    },
                    child: Text(t.sendRequest),
                  ),
                ],
              );
            },
          );
        }
      }
    }

    void handleVideoSelection() async {
      final otherUserProfile =
          await ref.watch(userProviderWithID(otherUser.id).future);
      final currentUserProfile =
          await ref.watch(userProviderWithID(currentUser!.uid).future);

      if (otherUserProfile.canRecieveVideos) {
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
            final otherUser = room.users.firstWhere(
              (u) => u.id != currentUser.uid,
            );
            messageServiceProvider.sendMessage(
              message,
              room.id,
              otherUser.id,
            );
          } catch (e) {
            Future.error("${t.errorUploadingVideo}: $e");
          }
        }
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(t.cantSendVideo),
                content: Text(t.userCantRecieveVideos),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      context.maybePop();
                    },
                    child: Text(t.ok),
                  ),
                  TextButton(
                    onPressed: () async {
                      final tokenSnapshot = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(otherUser.id)
                          .get();
                      final token =
                          tokenSnapshot.data()?['fcmToken'] as String?;
                      if (token != null) {
                        await sendPushNotification(
                          deviceToken: token,
                          title: t.recieveVideoTitle,
                          body: t.recieveVideoBody(
                              firstName: currentUserProfile.firstName),
                        );
                      }
                      if (context.mounted) {
                        Utils.show.toast(context, t.requestSended);
                        context.maybePop();
                      }
                    },
                    child: Text(t.sendRequest),
                  ),
                ],
              );
            },
          );
        }
      }
    }

    void handleAudioSelection() async {
      final otherUserProfile =
          await ref.watch(userProviderWithID(otherUser.id).future);
      final currentUserProfile =
          await ref.watch(userProviderWithID(currentUser!.uid).future);

      if (otherUserProfile.canRecieveAudios) {
        await startRecording();

        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              // Başlangıç zamanı
              final startTime = DateTime.now();

              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: Text(t.recording),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const CircularProgressIndicator(),
                        const SizedBox(height: 20),
                        Text(t.recordingInProgress),
                        TextButton(
                          onPressed: () async {
                            final uri = await stopRecording();
                            if (uri != null) {
                              final file = File(uri);
                              final size = file.lengthSync();

                              // Kayıt süresi hesaplanıyor
                              final duration =
                                  DateTime.now().difference(startTime);
                              final name = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();

                              final reference =
                                  FirebaseStorage.instance.ref('$name.aac');
                              await reference.putFile(file);
                              final downloadUri =
                                  await reference.getDownloadURL();

                              final message = types.PartialAudio(
                                duration: duration,
                                name: name,
                                size: size,
                                uri: downloadUri,
                              );

                              final otherUser = room.users.firstWhere(
                                (u) => u.id != currentUser.uid,
                              );
                              messageServiceProvider.sendMessage(
                                message,
                                room.id,
                                otherUser.id,
                              );
                            }
                            if (context.mounted) {
                              context.maybePop(); // Dialog kapatılıyor
                            }
                          },
                          child: Text(t.stopRecording),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(t.cantSendAudio),
                content: Text(t.userCantRecieveAudios),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      context.maybePop();
                    },
                    child: Text(t.ok),
                  ),
                  TextButton(
                    onPressed: () async {
                      final tokenSnapshot = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(otherUser.id)
                          .get();
                      final token =
                          tokenSnapshot.data()?['fcmToken'] as String?;
                      if (token != null) {
                        await sendPushNotification(
                          deviceToken: token,
                          title: t.recieveAudioTitle,
                          body: t.recieveAudioBody(
                              firstName: currentUserProfile.firstName),
                        );
                      }
                      if (context.mounted) {
                        Utils.show.toast(context, t.requestSended);
                        context.maybePop();
                      }
                    },
                    child: Text(t.sendRequest),
                  ),
                ],
              );
            },
          );
        }
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
                    context.maybePop();
                    handleImageSelection();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(t.photo),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.maybePop();
                    handleVideoSelection();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(t.video),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.maybePop();
                    handleAudioSelection();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(t.audio),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(t.cancel),
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
      messageServiceProvider.sendMessage(
        message,
        room.id,
        otherUser.id,
      );
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        ref.read(storageService).setLastSeenDateTime(room.id, DateTime.now());
        ref.invalidate(unreadMessageCountProvider(room.id));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              AsyncWidget<UserModel>(
                data: ref.watch(userProviderWithID(otherUser.id)),
                builder: (userData) {
                  return CustomImage.network(
                    userData.profileImages.first,
                    memCacheHeight: 100,
                    memCacheWidth: 100,
                    width: 50,
                    height: 50,
                    borderRadius: S.borderRadius.radius50,
                  );
                },
              ),
              S.sizedBox.w12,
              Text(room.name.toString()),
            ],
          ),
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
      ),
    );
  }
}
