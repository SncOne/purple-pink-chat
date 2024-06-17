import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/matching_service.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/ui/shared/widgets/image_viewer.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProfileDetailsPage extends HookConsumerWidget {
  final UserModel user;
  const ProfileDetailsPage({required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchingServiceProvider = ref.watch(matchingService);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.profile),
      ),
      body: Padding(
        padding: S.edgeInsets.all20,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              AsyncWidget<UserModel>(
                data: ref.watch(userProviderWithID(user.uid)),
                builder: (userData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  S.sizedBox.h46,
                                  Text(
                                    '${userData.firstName} ${userData.lastName}',
                                    style: S.textStyles.font16White,
                                  ),
                                  S.sizedBox.h6,
                                  Text(
                                    userData.location,
                                    style: S.textStyles.font16White,
                                  ),
                                  S.sizedBox.h6,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${userData.gender} / ',
                                        style: S.textStyles.font16White,
                                      ),
                                      Text(
                                        '${(DateTime.now().difference(userData.birthDate).inDays ~/ 365).toString()} years old',
                                        style: S.textStyles.font16White,
                                      ),
                                    ],
                                  ),
                                  S.sizedBox.h6,
                                  Text(
                                    userData.about ?? '',
                                    textAlign: TextAlign.center,
                                    style: S.textStyles.font16White,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Hero(
                                tag: userData.profileImages.first,
                                child: CircleAvatar(
                                  radius: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: S.borderRadius.radius50,
                                      border: Border.all(
                                        color: Colors.deepPurple,
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => ImageViewerPage(
                                                imageUrl: userData
                                                    .profileImages.first,
                                              ),
                                            ),
                                          );
                                        },
                                        child: CustomImage.network(
                                          userData.profileImages.first,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                          memCacheHeight: 200,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        t.hobbies,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: userData.hobiesAndInterests.map((interest) {
                          return Chip(
                            label: Text(interest),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: userData.profileImages.map((image) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ImageViewerPage(imageUrl: image),
                                ),
                              );
                            },
                            child: Hero(
                              tag: generateRandomString(15),
                              child: CustomImage.network(
                                image,
                                height: 150,
                                width: 150,
                                memCacheHeight: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        ElevatedButton(onPressed: () {}, child: const Text('Incoming')),
        ElevatedButton(
          onPressed: () async {
            final currentUser = matchingServiceProvider.user!;
            final roomId = await matchingServiceProvider.getRoomId(
                currentUser.uid, user.uid); // Odayı bulma işlemi

            if (roomId != null) {
              final room = types.Room(
                type: types.RoomType.direct,
                id: roomId,
                name: "${user.firstName} ${user.lastName}",
                users: const [],
              );

              if (context.mounted) {
                context.router.push(ChatRoute(room: room));
              }
            } else {
              if (context.mounted) {
                Utils.show.toast(context, "Chat room can't be found");
              }
            }
          },
          child: Text(t.messages),
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Super Like')),
      ],
    );
  }
}
