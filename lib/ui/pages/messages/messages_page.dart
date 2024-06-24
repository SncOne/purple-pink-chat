import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/storage_service.dart';
import 'package:catt_catt/ui/shared/pages/settings/settings_page.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:intl/intl.dart';

@RoutePage()
class MessagesPage extends HookConsumerWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formatTimestamp(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat('HH:mm').format(dateTime);
    }

    final currentUser = ref.read(authService).user;
    final storage = ref.read(storageService);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Utils.show.settings(context, const SettingsWidget());
            },
            child: SvgPicture.asset(R.icons.settings),
          ),
        ],
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No rooms'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room = snapshot.data![index];
              final otherUser = room.users.firstWhere(
                (u) => u.id != currentUser!.uid,
              );
              final userInfo = ref.watch(userProviderWithID(otherUser.id));

              ref.listen<AsyncValue<List<types.Message>>>(
                  newMessageStreamProvider(room.id), (previous, next) {
                next.whenData((messages) {
                  if (messages.isNotEmpty) {
                    final latestMessage = messages.first;
                    if (latestMessage.author.id != currentUser!.uid) {
                      storage.incrementUnreadCount(currentUser.uid);
                    }
                  }
                });
              });

              return GestureDetector(
                onTap: () {
                  storage.resetUnreadCount(currentUser.uid);
                  context.pushRoute(ChatRoute(room: room));
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  semanticContainer: false,
                  elevation: 5,
                  shadowColor: Colors.deepPurpleAccent,
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: S.edgeInsets.all5,
                    child: Row(
                      children: [
                        AsyncWidget<UserModel>(
                          data: userInfo,
                          builder: (userData) {
                            return CustomImage.network(
                              userData.profileImages.first,
                              memCacheHeight: 150,
                              memCacheWidth: 150,
                              width: 75,
                              height: 75,
                              borderRadius: S.borderRadius.radius50,
                            );
                          },
                        ),
                        S.sizedBox.w12,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(room.name ?? '',
                                  style: S.textStyles.font20BoldWhite),
                              S.sizedBox.h6,
                              AsyncWidget(
                                data: ref.watch(
                                    getLastMessageStreamProvider(room.id)),
                                builder: (lastMessage) {
                                  Print.info(lastMessage);
                                  String formattedTime =
                                      formatTimestamp(lastMessage['updatedAt']);
                                  if (lastMessage['type'] == 'video') {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text("A video Message",
                                              style: S.textStyles.font16White),
                                        ),
                                        Text(formattedTime,
                                            style: S.textStyles.font16White),
                                      ],
                                    );
                                  } else if (lastMessage['type'] == 'image') {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text("An image Message",
                                              style: S.textStyles.font16White),
                                        ),
                                        Text(formattedTime,
                                            style: S.textStyles.font16White),
                                      ],
                                    );
                                  } else if (lastMessage['type'] == 'audio') {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text("An audio Message",
                                              style: S.textStyles.font16White),
                                        ),
                                        Text(formattedTime,
                                            style: S.textStyles.font16White),
                                      ],
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(lastMessage['text'],
                                            style: S.textStyles.font16White),
                                      ),
                                      Text(formattedTime,
                                          style: S.textStyles.font16White),
                                    ],
                                  );
                                },
                              ),
                              Text(
                                  'Unread messages: ${storage.getUnreadCount(currentUser!.uid)}',
                                  style: S.textStyles.font16White),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
