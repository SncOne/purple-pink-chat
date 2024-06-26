import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/pages/chat/chat_provider.dart';
import 'package:catt_catt/ui/pages/messages/messages_provider.dart';
import 'package:catt_catt/ui/shared/pages/settings/settings_page.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

@RoutePage()
class MessagesPage extends HookConsumerWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formatTimestamp(Timestamp? timestamp) {
      DateTime dateTime = timestamp?.toDate() ?? DateTime.now();
      return DateFormat('HH:mm').format(dateTime);
    }

    final currentUser = ref.read(authService).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.messages),
        actions: [
          ElevatedButton(
            onPressed: () {
              Utils.show.settings(context, const SettingsWidget());
            },
            child: SvgPicture.asset(R.icons.settings),
          ),
        ],
      ),
      body: AsyncWidget(
        data: ref.watch(roomsProvider),
        builder: (list) {
          if (list.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Text(t.noRooms),
            );
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final room = list[index];
              final otherUser = room.users.firstWhere(
                (u) => u.id != currentUser!.uid,
              );

              return GestureDetector(
                onTap: () {
                  ref.read(selectedRoomProvider.notifier).setRoom(room);
                  context.pushRoute(ChatRoute(roomId: room.id));
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
                          data: ref.watch(userProviderWithID(otherUser.id)),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(room.name ?? '',
                                      style: S.textStyles.font20BoldWhite),
                                  UnreadMessageCount(room.id),
                                ],
                              ),
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
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .video_camera_back_outlined,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Text(t.video,
                                                  style:
                                                      S.textStyles.font16White),
                                            ],
                                          ),
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
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.image,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Text(t.photo,
                                                  style:
                                                      S.textStyles.font16White),
                                            ],
                                          ),
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
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.audiotrack_outlined,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Text(t.audio,
                                                  style:
                                                      S.textStyles.font16White),
                                            ],
                                          ),
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

class UnreadMessageCount extends ConsumerWidget {
  const UnreadMessageCount(this._roomId, {super.key});
  final String _roomId;

  @override
  Widget build(BuildContext context, ref) {
    return AsyncWidget(
      data: ref.watch(unreadMessageCountProvider(_roomId)),
      builder: (final int count) => count == 0
          ? const SizedBox.shrink()
          : Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: S.borderRadius.radius12,
              ),
              padding: S.edgeInsets.all5,
              child: Text(
                count.toString(),
                style: S.textStyles.font16White,
              ),
            ),
    );
  }
}
