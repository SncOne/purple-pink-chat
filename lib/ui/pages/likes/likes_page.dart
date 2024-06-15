import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/services/matching_service.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
              onTap: (user) {
                // Diyalog açma işlemi
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('${user.firstName} ${user.lastName}'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('İsmi: ${user.firstName}'),
                          Text('Location: ${user.location}'),
                          // Diğer bilgileri ekleyin
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            LikesList(
              stream: matchingServiceProvider
                  .getLikedList(matchingServiceProvider.user!.uid),
              onTap: (user) {
                // Diyalog açma işlemi
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('${user.firstName} ${user.lastName}'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('İsmi: ${user.firstName}'),
                          Text('Location: ${user.location}'),
                          // Diğer bilgileri ekleyin
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            LikesList(
              stream: matchingServiceProvider
                  .getMatchedList(matchingServiceProvider.user!.uid),
              onTap: (user) {
                // Diyalog açma işlemi
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('${user.firstName} ${user.lastName}'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('İsmi: ${user.firstName}'),
                          Text('Location: ${user.location}'),
                          // Diğer bilgileri ekleyin
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
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
  const LikesList({required this.stream, required this.onTap, super.key});

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
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Data Available'));
        }
        final docs = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
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
                  return Center(child: Text('Error: ${profileSnapshot.error}'));
                }
                if (!profileSnapshot.hasData) {
                  return const Center(child: Text('Profile not found'));
                }

                final user = profileSnapshot.data!;

                return GestureDetector(
                  onTap: () => onTap(user),
                  child: Card(
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
                );
              },
            );
          },
        );
      },
    );
  }
}
