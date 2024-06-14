import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/matching_service.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/profile_card.dart';
import 'package:catt_catt/ui/shared/widgets/profile_card_provider.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileCards extends HookConsumerWidget {
  const ProfileCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(userProvider);
    final matchingProvider = ref.read(matchingService);
    return AsyncWidget<List<UserModel>>(
      data: ref.watch(profilesProvider),
      builder: (userData) {
        if (userData.isEmpty) {
          return Container(
            color: Colors.deepPurple,
            padding: S.edgeInsets.all20,
            margin: S.edgeInsets.all20,
            height: 500,
            alignment: Alignment.center,
            child: Text(
              'Hi unfortunately there isnt any cool person in here yet check later on',
              style: S.textStyles.font18BoldWhite,
            ),
          );
        }
        return CardSwiper(
          cardsCount: userData.length,
          backCardOffset: const Offset(0, 30),
          isLoop: false,
          numberOfCardsDisplayed: 1,
          onSwipe: (
            int previousIndex,
            int? currentIndex,
            CardSwiperDirection direction,
          ) {
            if (direction == CardSwiperDirection.left) {
            } else if (direction == CardSwiperDirection.right) {
              matchingProvider.addToLikedList(
                  userData[previousIndex].uid, currentUser.value!.uid);
            }
            return true;
          },
          allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
            horizontal: true,
            vertical: false,
          ),
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
            return ProviderScope(
              overrides: [
                profileCardProvider.overrideWithValue(userData[index]),
                profileCardThresholdProvider
                    .overrideWithValue(percentThresholdX),
              ],
              child: const ProfileCard(),
            );
          },
        );
      },
    );
  }
}
