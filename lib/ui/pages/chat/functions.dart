import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/messages_service.dart';
import 'package:catt_catt/core/services/send_push_notification.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

Future<void> handleImageSelection(WidgetRef ref, BuildContext context,
    String otherUserId, String roomId) async {
  final messageServiceProvider = ref.watch(messagesService);
  final currentUser = ref.read(authService).user;
  final otherUserProfile =
      await ref.watch(getUserStreamWithId(otherUserId).future);
  final currentUserProfile =
      await ref.watch(getUserStreamWithId(currentUser!.uid).future);
  if (otherUserProfile.canRecieveImages) {
    final result = await ImagePicker().pickMultiImage(
      imageQuality: 25,
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
          roomId,
          otherUserId,
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
                      .doc(otherUserId)
                      .get();
                  final token = tokenSnapshot.data()?['fcmToken'] as String?;
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

Future<void> handleVideoSelection(WidgetRef ref, BuildContext context,
    String otherUserId, String roomId) async {
  final messageServiceProvider = ref.watch(messagesService);
  final currentUser = ref.read(authService).user;

  final otherUserProfile =
      await ref.watch(getUserStreamWithId(otherUserId).future);
  final currentUserProfile =
      await ref.watch(getUserStreamWithId(currentUser!.uid).future);

  if (otherUserProfile.canRecieveVideos) {
    final result = await ImagePicker().pickVideo(
      maxDuration: const Duration(seconds: 30),
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
          roomId,
          otherUserId,
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
                      .doc(otherUserId)
                      .get();
                  final token = tokenSnapshot.data()?['fcmToken'] as String?;
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
