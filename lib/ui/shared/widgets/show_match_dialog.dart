import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/providers/match_notifier_provider.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/matching_service.dart';
import 'package:catt_catt/ui/shared/widgets/async_widget.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class ShowMatchDialog extends ConsumerWidget {
  const ShowMatchDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchState = ref.watch(matchNotifierProvider);
    final matchingServiceProvider = ref.watch(matchingService);
    final user = ref.watch(userProviderWithID(matchState.toUserId));
    if (!matchState.showDialog) {
      return const SizedBox.shrink();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  R.anims.matchingHearts,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 20,
                  child: AsyncWidget<UserModel>(
                    data:
                        ref.watch(userProviderWithID(matchState.currentUserId)),
                    builder: (userData) {
                      return CustomImage.network(
                        userData.profileImages.first,
                        fit: BoxFit.cover,
                        memCacheHeight: 200,
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 20,
                  child: AsyncWidget<UserModel>(
                    data: ref.watch(userProviderWithID(matchState.toUserId)),
                    builder: (userData) {
                      return CustomImage.network(
                        userData.profileImages.first,
                        fit: BoxFit.cover,
                        memCacheHeight: 200,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: IconButton(
                    icon: const Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 50,
                    ),
                    onPressed: () async {
                      final roomId = await matchingServiceProvider.getRoomId(
                          matchState.currentUserId, matchState.toUserId);

                      if (roomId != null) {
                        final room = types.Room(
                          type: types.RoomType.direct,
                          id: roomId,
                          name:
                              "${user.value?.firstName} ${user.value?.lastName}",
                          users: const [],
                        );

                        if (context.mounted) {
                          context.router.push(ChatRoute(room: room));
                        }
                      } else {
                        if (context.mounted) {
                          Utils.show.toast(context, "Chat room can't be found");
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      ref.read(matchNotifierProvider.notifier).hideMatchDialog();
    });

    return const SizedBox.shrink();
  }
}
