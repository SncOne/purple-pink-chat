import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authService);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(t.hello(name: auth.user!.displayName!)),
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
