import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/send_push_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:catt_catt/core/services/messages_service.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';

class AudioRecorderDialog extends HookConsumerWidget {
  final String otherUserId;
  final String roomId;

  const AudioRecorderDialog({
    super.key,
    required this.otherUserId,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioRecorder = useMemoized(() => FlutterSoundRecorder());
    final isRecording = useState(false);
    final startTime = useState<DateTime?>(null);

    useEffect(() {
      audioRecorder.openRecorder();
      return () => audioRecorder.closeRecorder();
    }, [audioRecorder]);

    Future<void> startRecording() async {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException(t.microphonePermissionNotGranted);
      }

      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

      try {
        await audioRecorder.startRecorder(toFile: path);
        isRecording.value = true;
        startTime.value = DateTime.now();
      } catch (e) {
        Future.error("${t.error}: $e");
      }
    }

    Future<String?> stopRecording() async {
      if (audioRecorder.isRecording) {
        final uri = await audioRecorder.stopRecorder();
        isRecording.value = false;
        return uri;
      }
      return null;
    }

    Future<void> sendRecording() async {
      final uri = await stopRecording();

      if (uri != null) {
        final file = File(uri);
        final size = file.lengthSync();
        final duration = DateTime.now().difference(startTime.value!);
        final name = DateTime.now().millisecondsSinceEpoch.toString();

        final reference = FirebaseStorage.instance.ref('$name.aac');
        await reference.putFile(file);
        final downloadUri = await reference.getDownloadURL();

        final message = types.PartialAudio(
          duration: duration,
          name: name,
          size: size,
          uri: downloadUri,
        );
        if (context.mounted) {
          context.maybePop();
        }
        final messageServiceProvider = ref.watch(messagesService);
        messageServiceProvider.sendMessage(
          message,
          roomId,
          otherUserId,
        );
      }
    }

    return AlertDialog(
      title: Text(t.recording),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isRecording.value
              ? const CircularProgressIndicator()
              : const Icon(Icons.mic, size: 64),
          const SizedBox(height: 20),
          Text(isRecording.value ? t.recordingInProgress : t.readyToRecord),
          TextButton(
            onPressed: isRecording.value ? sendRecording : startRecording,
            child: Text(isRecording.value ? t.stopRecording : t.startRecording),
          ),
        ],
      ),
    );
  }
}

Future<void> handleAudioSelection(WidgetRef ref, BuildContext context,
    String otherUserId, String roomId) async {
  final otherUserProfile =
      await ref.watch(getUserStreamWithId(otherUserId).future);
  if (otherUserProfile.canRecieveAudios) {
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AudioRecorderDialog(
            otherUserId: otherUserId,
            roomId: roomId,
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
                  Navigator.of(context).pop();
                },
                child: Text(t.ok),
              ),
              TextButton(
                onPressed: () async {
                  final tokenSnapshot = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(otherUserId)
                      .get();
                  final token = tokenSnapshot.data()?['fcmToken'] as String?;
                  if (token != null) {
                    await sendPushNotification(
                      deviceToken: token,
                      title: t.recieveAudioTitle,
                      body: t.recieveAudioBody(
                          firstName: otherUserProfile.firstName),
                    );
                  }
                  if (context.mounted) {
                    Utils.show.toast(context, t.requestSended);
                    Navigator.of(context).pop();
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
