import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/shared/widgets/profile_card.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:catt_catt/ui/shared/widgets/empty_widget.dart';

@RoutePage()
class DiscoverPage extends HookConsumerWidget {
  const DiscoverPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authService);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Utils.show.dialog(
                    context, const Empty.dialog(content: Text('Filterr')));
              },
              child: SvgPicture.asset(R.icons.filter))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProfileCard(),
            ElevatedButton(
              onPressed: () async {
                await auth.logout();
              },
              child: Text(t.logout),
            )
          ],
        ),
      ),
    );
  }
}
