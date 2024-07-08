import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/slang_enum_functions.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/ui/shared/widgets/image_viewer.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.updateProfile),
        actions: [
          IconButton(
            icon: SvgPicture.asset(R.icons.edit),
            onPressed: () {
              context.pushRoute(const EditProfileRoute());
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.showLoading(ref.read(authService).logout);
              context.router.replace(const WelcomeRoute());
            },
            child: Text(t.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: AsyncWidget<UserModel>(
            data: ref.watch(userStreamProvider),
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
                            color: const Color(0xff200F3A),
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
                                    '${t.genderList(gender: stringToGenderContext(userData.gender.name))} / ',
                                    style: S.textStyles.font16White,
                                  ),
                                  Text(
                                    '${(DateTime.now().difference(userData.birthDate).inDays ~/ 365).toString()} ${t.yearsOld}',
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
                                    color: const Color(0xff200F3A),
                                    width: 3,
                                  ),
                                ),
                                child: ClipOval(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ImageViewerPage(
                                            imageUrl:
                                                userData.profileImages.first,
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
                        label: Text(t.hobbyList(
                            hobby: stringToHobbyContext(interest.name))),
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
                              builder: (_) => ImageViewerPage(imageUrl: image),
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
        ),
      ),
    );
  }
}
