import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/ui/shared/widgets/profile_card_like_status.dart';
import 'package:catt_catt/ui/shared/widgets/profile_card_provider.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(profileCardProvider);
    return Column(
      children: [
        Stack(
          children: [
            CustomImage.network(
              user.profileImages.first,
              height: MediaQuery.sizeOf(context).height / 1.4,
              width: 500,
              memCacheHeight: MediaQuery.sizeOf(context).height.toInt(),
              borderRadius: S.borderRadius.radius12,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: S.edgeInsets.all5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white70,
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                      borderRadius: S.borderRadius.radius16,
                    ),
                    child: Text(
                      '${user.firstName} ${user.lastName}',
                      style: S.textStyles.font16White,
                    ),
                  ),
                  Container(
                    padding: S.edgeInsets.all5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white70,
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                      borderRadius: S.borderRadius.radius16,
                    ),
                    child: Text(
                      '${(DateTime.now().difference(user.birthDate).inDays ~/ 365).toString()} years old',
                      style: S.textStyles.font16White,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: S.edgeInsets.all5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white70,
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                      borderRadius: S.borderRadius.radius16,
                    ),
                    child: Text(
                      user.location,
                      style: S.textStyles.font16White,
                    ),
                  )
                ],
              ),
            ),
            const ProfileCardLikeStatusCard(),
          ],
        ),
      ],
    );
  }
}
