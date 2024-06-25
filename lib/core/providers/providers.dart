import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/matching_service.dart';
import 'package:catt_catt/core/services/messages_service.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final emailController = Provider.autoDispose<TextEditingController>((ref) {
  return ref.useTextEditingController();
});

final passwordController = Provider.autoDispose<TextEditingController>((ref) {
  return ref.useTextEditingController();
});

final nameController = Provider.autoDispose<TextEditingController>((ref) {
  return ref.useTextEditingController();
});

final lastNameController = Provider.autoDispose<TextEditingController>((ref) {
  return ref.useTextEditingController();
});

final aboutController = Provider.autoDispose<TextEditingController>((ref) {
  return ref.useTextEditingController();
});

final authProvider = Provider.autoDispose<AuthService>((ref) {
  return ref.state;
});

final animationController = Provider.autoDispose<AnimationController>((ref) {
  return ref.useAnimationController();
});

final authServiceProvider = Provider((ref) => const AuthService());

final userProvider = FutureProvider.autoDispose<UserModel>((ref) async {
  final authService = ref.read(authServiceProvider);
  final userData = await authService.getUser();
  return UserModel.fromJson(userData);
});

final userStreamProvider = StreamProvider.autoDispose<UserModel>((ref) {
  final authServiceController = ref.watch(authService);
  return authServiceController.getUserStream();
});

final profilesProvider = StreamProvider.autoDispose<List<UserModel>>((ref) {
  final authService = ref.read(authServiceProvider);
  return authService.getProfilesStream();
});

final userProviderWithID =
    FutureProvider.family<UserModel, String>((ref, userId) async {
  final authService = ref.read(authServiceProvider);
  return authService.getUserWithID(userId);
});

final getUserStreamWithId =
    StreamProvider.autoDispose.family<UserModel, String>((ref, userId) {
  final authService = ref.watch(authServiceProvider);
  return authService.getUserStreamWithID(userId);
});

final getLastMessageStreamProvider = StreamProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, roomId) {
  final authServiceController = ref.watch(messagesService);
  return authServiceController.getLatestMessageStream(roomId);
});

final getLikedList = StreamProvider.autoDispose
    .family<QuerySnapshot<Object?>, String>((ref, userId) {
  final matchingServiceController = ref.watch(matchingService);
  return matchingServiceController.getLikedList(userId);
});

final getMatchedList = StreamProvider.autoDispose
    .family<QuerySnapshot<Object?>, String>((ref, userId) {
  final matchingServiceController = ref.watch(matchingService);
  return matchingServiceController.getMatchedList(userId);
});

final getLikesYouList = StreamProvider.autoDispose
    .family<QuerySnapshot<Object?>, String>((ref, userId) {
  final matchingServiceController = ref.watch(matchingService);
  return matchingServiceController.getLikesYouList(userId);
});
