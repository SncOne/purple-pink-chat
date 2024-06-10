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
                  backCardOffset: const Offset(0, 30),
                  onSwipe: (
                    int previousIndex,
                    int? currentIndex,
                    CardSwiperDirection direction,
                  ) {
                    if (direction == CardSwiperDirection.left) {
                    } else if (direction == CardSwiperDirection.right) {}
                    return true;
                  },
                  allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
                      horizontal: true, vertical: false),
                  cardBuilder:
                      (context, index, percentThresholdX, percentThresholdY) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            CustomImage.network(
                              userData[index].profileImages.first,
                              height: 600,
                              width: 500,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: S.edgeInsets.all5,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          40, 104, 58, 183),
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
                                      '${userData[index].firstName} ${userData[index].lastName}',
                                      style: S.textStyles.font16White,
                                    ),
                                  ),
                                  Container(
                                    padding: S.edgeInsets.all5,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          40, 104, 58, 183),
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
                                      '${(DateTime.now().difference(userData[index].birthDate).inDays ~/ 365).toString()} years old',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: S.edgeInsets.all5,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          40, 104, 58, 183),
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
                                      userData[index].location,
                                      style: S.textStyles.font16White,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            percentThresholdX == 0
                                ? const SizedBox()
                                : Positioned(
                                    top: 250,
                                    left: 150,
                                    child: Row(
                                      children: [
                                        Icon(
                                          percentThresholdX < 0
                                              ? Icons.heart_broken
                                              : Icons.favorite,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                        Text(percentThresholdX < 0
                                            ? 'Disliked'
                                            : 'Liked')
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
