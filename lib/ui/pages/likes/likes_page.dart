import 'dart:js_interop';

import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/matching_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LikesPage extends HookConsumerWidget {
  const LikesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesService = ref.watch(matchingService);
    final user = ref.watch(authService).user;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Likes"),
        ),
        body: StreamBuilder(
            stream: likesService.getLikesYouList(user?.uid),
            builder: (context, snapshot) {
              return Text(snapshot.data.jsify().toString());
            }));
  }
}
