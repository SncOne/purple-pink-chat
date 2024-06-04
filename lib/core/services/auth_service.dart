import 'dart:developer';
import 'dart:io';

import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authService = Provider((ref) => const AuthService());

final class AuthService {
  const AuthService();

  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _store => FirebaseFirestore.instance;
  FirebaseStorage get _storage => FirebaseStorage.instance;

  User? get user => _auth.currentUser;
  get storeInfo => _store.collection('users').doc(user?.uid);
  Stream<User?> get authState => _auth.authStateChanges();

  Future<UserCredential> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Utils.show.toast(context, e.message!);
      rethrow;
    }
  }

  Future getUser() async {
    if (user?.uid.isEmpty ?? true) {
      return;
    }
    final userDoc = await storeInfo.get();

    if (!userDoc.exists) {
      return;
    }
    final userData = userDoc.data();
    return userData;
  }

  Future<String> uploadImage({
    required pickedFile,
    required BuildContext context,
  }) async {
    try {
      final path = '/files${pickedFile.name}';
      final file = File(pickedFile.path);
      final upload = await _storage.ref().child(path).putFile(file);
      final imageUrl = upload.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      log('Error updating user display name: $e');
      rethrow;
    }
  }

  Future updateProfile({
    List<String>? profileImages,
    String? firstName,
    String? lastName,
    String? gender,
    String? birthDate,
    String? location,
    List<String>? hobiesAndInterests,
    String? interestedGender,
    String? lookingFor,
    String? sexualOrientation,
  }) async {
    if (user != null) {
      await user!.updateDisplayName('$firstName $lastName');
      await storeInfo.set({
        "uid": user!.uid,
        "firstName": firstName ?? '',
        "lastName": lastName ?? '',
        "profileImages": profileImages ?? [],
        "gender": gender ?? '',
        "birthDate": birthDate ?? '',
        "location": location ?? '',
        "hobiesAndInterests": hobiesAndInterests ?? [],
        "interestedGender": interestedGender ?? '',
        "lookingFor": lookingFor ?? '',
        "sexualOrientation": sexualOrientation ?? '',
      });
    }
  }

  Future<List<UserModel>>? getProfiles() async {
    final usersProfileList = <UserModel>[];
    if (user != null) {
      final usersProfilesQuery =
          _store.collection('users').where('uid', isNotEqualTo: user!.uid);

      final usersProfilesSnapshot = await usersProfilesQuery.get();

      final usersProfiles = usersProfilesSnapshot.docs;

      for (var doc in usersProfiles) {
        Print.warning(doc.data());
        usersProfileList.add(UserModel.fromJson(doc.data()));
      }
    }
    return usersProfileList;
  }

  Future<UserCredential?> register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final createdUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return createdUser;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Utils.show.toast(context, e.message!);
      }
      return null;
    } catch (e) {
      Print.error("Unexpected error during registration: $e");
      if (context.mounted) {
        Utils.show.toast(context, e.toString());
      }
      return null;
    }
  }

  Future<void> forgotPw(
    String email,
    BuildContext context,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Utils.show.toast(context, e.message!);
      }
    }
  }

  Future<void> updatePassword(
    String currentPassword,
    String newPassword,
    BuildContext context,
  ) async {
    try {
      await _auth.currentUser?.reauthenticateWithCredential(
          const AuthCredential(
              providerId: 'google.com', signInMethod: 'password'));

      await _auth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Utils.show.toast(context, e.message!);
      }
    }
  }

  Future<void> deleteAccount(
    String email,
    BuildContext context,
  ) async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Utils.show.toast(context, e.message!);
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
