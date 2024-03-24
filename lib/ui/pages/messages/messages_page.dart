import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MessagesPage extends HookConsumerWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: const Center(
        child: Text("Messages"),
      ),
    );
  }
}
