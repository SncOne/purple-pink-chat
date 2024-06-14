import 'package:catt_catt/ui/shared/widgets/profile_card_provider.dart';
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
          child: Row(
            children: [
              Icon(
                percentThresholdX < 0 ? Icons.heart_broken : Icons.favorite,
                color: Colors.red,
                size: 40,
              ),
              Text(percentThresholdX < 0 ? 'Disliked' : 'Liked')
            ],
          ),
        )
    };
  }
}
