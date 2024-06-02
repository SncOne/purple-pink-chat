import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:catt_catt/ui/shared/widgets/empty_widget.dart';
@RoutePage()
class MessagesPage extends HookConsumerWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [ElevatedButton(onPressed:(){
          Utils.show.bottomSheet(context,Column(children: [],));
        }, child:SvgPicture.asset(R.icons.settings))],
      ),
      body: const Center(
        child: Text("Messages"),
      ),
    );
  }
}
