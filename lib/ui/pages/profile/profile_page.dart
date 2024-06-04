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
        title: const Text("Profile"),
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
        padding: S.edgeInsets.all20,
        child: AsyncWidget<UserModel>(
          data: userAsyncValue,
          builder: (userData) {
            return Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 60,
                  backgroundImage: NetworkImage(userData.profileImages.first),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${userData.firstName} ${userData.lastName}',
                    ),
                    Text(
                      userData.gender,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(width: 5),
                    Text(userData.location),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.interests),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        userData.hobiesAndInterests.isNotEmpty
                            ? userData.hobiesAndInterests.join(', ')
                            : 'No interests',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.heart_broken),
                    const SizedBox(width: 5),
                    Text(userData.lookingFor),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.arrow_drop_down),
                    const SizedBox(width: 5),
                    Text(userData.sexualOrientation),
                  ],
                ),
                Wrap(
                  spacing: 13.2,
                  runSpacing: 12.8,
                  children: List.generate(
                    userData.profileImages.length,
                    (image) => CustomImage.network(
                      userData.profileImages[image],
                      memCacheWidth: 170,
                      memCacheHeight: 170,
                      height: 170,
                      width: 170,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
