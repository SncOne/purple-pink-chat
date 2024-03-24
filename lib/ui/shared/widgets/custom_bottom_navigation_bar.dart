//import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends HookConsumerWidget {
  final Widget child;
  final TabsRouter tabsRouter;
  const CustomBottomNavigationBar(this.tabsRouter, this.child, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Print.error(context.routeData.path);
    Print.warning(context.router.stack);
    Print.info(context.router.current.path);

    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: (index) => tabsRouter.setActiveIndex(index),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.explore,
            ),
            title: const Text(
              "Discover",
            ),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text("Likes"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.message),
            title: const Text("Messages"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
      body: child,
    );
  }
}
/**import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomBottomNavigationBar extends HookConsumerWidget {
  final Widget child;
  final TabsRouter tabsRouter;
  const CustomBottomNavigationBar(this.tabsRouter, this.child, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Print.error(context.routeData.path);
    Print.warning(context.router.stack);
    Print.info(context.router.current.path);
    final notchBottomBarController =
        NotchBottomBarController(index: tabsRouter.activeIndex);
    return Scaffold(
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: notchBottomBarController,
        color: Colors.white,
        showLabel: false,
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: const Color(0xffF0EBFA),
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.pink,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.pink,
            ),
            itemLabel: 'Page 1',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Colors.pink,
            ),
            activeItem: Icon(
              Icons.person,
              color: Colors.pink,
            ),
            itemLabel: 'Page 5',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.heart_broken,
              color: Colors.pink,
            ),
            activeItem: Icon(
              Icons.heart_broken,
              color: Colors.pink,
            ),
            itemLabel: 'Page 2',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.message,
              color: Colors.pink,
            ),
            activeItem: Icon(
              Icons.message,
              color: Colors.pink,
            ),
            itemLabel: 'Page 4',
          ),
        ],
        onTap: (index) {
          tabsRouter.setActiveIndex(index);
          notchBottomBarController.jumpTo(index);
          Print.error(tabsRouter.currentPath);
          Print.error(child);
        },
        kIconSize: 24.0,
      ),
      body: child,
    );
  }
}
 */