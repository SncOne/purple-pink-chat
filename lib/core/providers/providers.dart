import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

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

final profilesProvider =
    FutureProvider.autoDispose<List<UserModel>>((ref) async {
  final authService = ref.read(authServiceProvider);
  final userModels = await authService.getProfiles();
  return userModels ?? [];
});
