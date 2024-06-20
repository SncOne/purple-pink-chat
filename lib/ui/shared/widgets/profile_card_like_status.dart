import 'package:catt_catt/core/providers/profile_card_provider.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileCardLikeStatusCard extends ConsumerWidget {
  const ProfileCardLikeStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentThresholdX = ref.watch(profileCardThresholdProvider);
    return switch (percentThresholdX) {
      0 => const SizedBox.shrink(),
      _ => Positioned(
          top: 250,
          left: 150,
          child: Container(
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
            child: Row(
              children: [
                Icon(
                  percentThresholdX < 0 ? Icons.heart_broken : Icons.favorite,
                  color: Colors.red,
                  size: 40,
                ),
                Text(
                  percentThresholdX < 0 ? 'Disliked' : 'Liked',
                  style: S.textStyles.font16White,
                )
              ],
            ),
          ),
        )
    };
  }
}
