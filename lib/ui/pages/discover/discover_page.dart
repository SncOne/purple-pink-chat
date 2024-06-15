import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/shared/widgets/empty_widget.dart';
import 'package:catt_catt/ui/shared/widgets/profile_cards.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class DiscoverPage extends HookConsumerWidget {
  const DiscoverPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.discover),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Utils.show.dialog(
                    context, const Empty.dialog(content: Text('Filterr')));
                ref.read(authService).getProfilesStream();
              },
              child: SvgPicture.asset(R.icons.filter))
        ],
      ),
      body: const ProfileCards(),
    );
  }
}
