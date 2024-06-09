import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileCard extends HookConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(profilesProvider);

    return Flexible(
      child: AsyncWidget<List<UserModel>>(
          data: userAsyncValue,
          builder: (userData) {
            return userData.isEmpty
                ? Container(
                    color: Colors.deepPurple,
                    padding: S.edgeInsets.all20,
                    margin: S.edgeInsets.all20,
                    height: 500,
                    alignment: Alignment.center,
                    child: Text(
                      'Hi unfortunately there isnt any cool person in here yet check later on',
                      style: S.textStyles.font18BoldWhite,
                    ),
                  )
                : CardSwiper(
                    cardsCount: userData.length,
                    allowedSwipeDirection:
                        const AllowedSwipeDirection.symmetric(
                            horizontal: true, vertical: false),
                    cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) =>
                        Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(userData[index].firstName),
                            Text(
                              '${(DateTime.now().difference(userData[index].birthDate).inDays ~/ 365).toString()} years old',
                            )
                          ],
                        ),
                        CustomImage.network(
                          userData[index].profileImages.first,
                          height: 500,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  );
          }),
    );
  }
}
