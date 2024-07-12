import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/shared/widgets/empty_widget.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Empty.dialog(
          image: R.images.noConnection,
          title: t.noConnectionTitle,
          desc: t.noConnectionDescription,
        ),
      ),
    );
  }
}
