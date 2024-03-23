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

final authProvider = Provider.autoDispose<AuthService>((ref) {
  return ref.state;
});
