import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/shared/widgets/empty_widget.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Empty.dialog(
          image: R.icons.notFound,
          title: 'not_found_title',
          desc: 'not_found_descp',
        ),
      ),
    );
  }
}
