import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomBottomNavigationBar extends HookWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => NotchBottomBarController());
    return SafeArea(
      child: AnimatedNotchBottomBar(
        notchBottomBarController: controller,
        color: Colors.white,
        showLabel: false,
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: Colors.deepPurple,
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        onTap: AutoTabsRouter.of(context).setActiveIndex,
        kIconSize: 24.0,
        bottomBarItems: [
          BottomBarItem(
            activeItem: const Icon(
              Icons.explore,
              color: Colors.white,
            ),
            inActiveItem: const Icon(
              Icons.explore,
              color: Colors.deepPurple,
            ),
            itemLabel: t.discover,
          ),
          BottomBarItem(
            activeItem: const Icon(
              Icons.message,
              color: Colors.white,
            ),
            inActiveItem: const Icon(
              Icons.message,
              color: Colors.deepPurple,
            ),
            itemLabel: t.messages,
          ),
          BottomBarItem(
            activeItem: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            inActiveItem: const Icon(
              Icons.favorite_border,
              color: Colors.deepPurple,
            ),
            itemLabel: t.likes,
          ),
          BottomBarItem(
            activeItem: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            inActiveItem: const Icon(
              Icons.person,
              color: Colors.deepPurple,
            ),
            itemLabel: t.profile,
          ),
        ],
      ),
    );
  }
}
