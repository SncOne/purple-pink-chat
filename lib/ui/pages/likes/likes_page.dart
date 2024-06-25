// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/services/matching_service.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

@RoutePage()
class LikesPage extends ConsumerWidget {
  const LikesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchingServiceProvider = ref.watch(matchingService);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Matches'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Likes You'),
              Tab(text: 'Your Likes'),
              Tab(text: 'Your Matches'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LikesList(
              stream: matchingServiceProvider
                  .getLikesYouList(matchingServiceProvider.user!.uid),
              onTap: (user) => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('To See This Profile'),
                  content: const Text('You Need to Subscribe'),
                  // PaywallView(
                  //   onRestoreCompleted: (customerInfo) {
                  //     // Optional listener. Called when a restore has been completed.
                  //     // This may be called even if no entitlements have been granted.
                  //   },
                  // ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.maybePop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
              isObsecured: true,
            ),
            LikesList(
              stream: matchingServiceProvider
                  .getLikedList(matchingServiceProvider.user!.uid),
              onTap: (user) =>
                  context.pushRoute(ProfileDetailsRoute(user: user)),
              isObsecured: false,
            ),
            LikesList(
              stream: matchingServiceProvider
                  .getMatchedList(matchingServiceProvider.user!.uid),
              onTap: (user) =>
                  context.pushRoute(ProfileDetailsRoute(user: user)),
              isObsecured: false,
            ),
          ],
        ),
      ),
    );
  }
}

class LikesList extends ConsumerWidget {
  final Stream<QuerySnapshot> stream;
  final Function(UserModel) onTap;
  final bool isObsecured;

  const LikesList({
    required this.stream,
    required this.onTap,
    required this.isObsecured,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchingServiceProvider = ref.watch(matchingService);

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('${t.error}: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text(t.noDataAvailable));
        }
        final docs = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 3,
          ),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            return FutureBuilder<UserModel>(
              future: matchingServiceProvider.getUserProfile(doc.id),
              builder: (context, profileSnapshot) {
                if (profileSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (profileSnapshot.hasError) {
                  return Center(
                      child: Text('${t.error}: ${profileSnapshot.error}'));
                }
                if (!profileSnapshot.hasData) {
                  return Center(child: Text(t.noDataAvailable));
                }

                final user = profileSnapshot.data!;

                return GestureDetector(
                  onTap: () => onTap(user),
                  child: Stack(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: CustomImage.network(
                                user.profileImages.first,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                                memCacheHeight: 300,
                              ),
                            ),
                            Text('${user.firstName} ${user.lastName}'),
                          ],
                        ),
                      ),
                      if (isObsecured)
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: const SizedBox.shrink(),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
