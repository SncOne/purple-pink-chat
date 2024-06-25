import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  final String otherUserId;
  final String roomName;

  const ChatAppBar(
      {required this.otherUserId, required this.roomName, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Row(
        children: [
          AsyncWidget<UserModel>(
            data: ref.watch(userProviderWithID(otherUserId)),
            builder: (userData) {
              return CustomImage.network(
                userData.profileImages.first,
                memCacheHeight: 100,
                memCacheWidth: 100,
                width: 50,
                height: 50,
                borderRadius: S.borderRadius.radius50,
              );
            },
          ),
          S.sizedBox.w12,
          Text(roomName),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
