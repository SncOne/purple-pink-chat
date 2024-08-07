import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/admob_service.dart';
import 'package:catt_catt/core/services/matching_service.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/profile_card.dart';
import 'package:catt_catt/core/providers/profile_card_provider.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileCards extends HookConsumerWidget {
  const ProfileCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);
    final matchingProvider = ref.read(matchingService);
    final profileData = ref.watch(profilesProvider);
    final lastCard = useState(false);
    return AsyncWidget(
      data: profileData,
      builder: (userData) {
        if (userData.isEmpty) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepPurple, Colors.pinkAccent],
              ),
            ),
            padding: S.edgeInsets.all20,
            margin: S.edgeInsets.all20,
            height: MediaQuery.sizeOf(context).height / 1.52,
            alignment: Alignment.center,
            child: Text(
              t.noProfile,
              style: S.textStyles.font18BoldWhite,
            ),
          );
        }

        return CardSwiper(
          cardsCount: userData.length + 1,
          backCardOffset: const Offset(0, 30),
          isLoop: false,
          numberOfCardsDisplayed: 1,
          isDisabled: lastCard.value,
          onSwipe: (
            int previousIndex,
            int? currentIndex,
            CardSwiperDirection direction,
          ) {
            Print.info(previousIndex, userData.length.toString());
            if (previousIndex > userData.length - 2) {
              lastCard.value = true;
              ref.read(admobService.notifier).videoAd();
            }
            if (direction == CardSwiperDirection.left) {
            } else if (direction == CardSwiperDirection.right) {
              matchingProvider.addToLikedList(
                userData[previousIndex].uid,
                currentUser.value!.uid,
                ref,
                context,
              );
            }
            return true;
          },
          allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
            horizontal: true,
            vertical: false,
          ),
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
            if (index == userData.length) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.deepPurple, Colors.pinkAccent],
                  ),
                ),
                padding: S.edgeInsets.all20,
                margin: S.edgeInsets.all20,
                height: MediaQuery.sizeOf(context).height / 1.52,
                alignment: Alignment.center,
                child: Text(
                  t.noDataAvailable,
                  style: S.textStyles.font18BoldWhite,
                ),
              );
            }

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
