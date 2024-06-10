import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("UPDATE PROFILE"),
        actions: [
          IconButton(
            icon: SvgPicture.asset(R.icons.edit),
            onPressed: () {
              // Push to edit profile page
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: AsyncWidget<UserModel>(
          data: userAsyncValue,
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
                              'XXXXXXXX XXXX\nXXXX XXXXXXX XXXXX\nXXXXX XXXXXXX XXXX XXXXX',
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
                              child: CustomImage.network(
                                userData.profileImages.first,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hobbies & Interest',
                  style: TextStyle(
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
                    return CustomImage.network(
                      image,
                      height: 150,
                      width: 150,
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
