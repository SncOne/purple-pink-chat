import 'dart:developer';
import 'dart:io';

import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/services/location_service.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authService = Provider((ref) => const AuthService());

final class AuthService {
  const AuthService();

  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _store => FirebaseFirestore.instance;
  FirebaseStorage get _storage => FirebaseStorage.instance;

  LocationService get _locationService => const LocationService();

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

  Future<UserModel> getUserWithID(String id) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    final userData = userDoc.data();
    return UserModel.fromJson(userData!);
  }

  Stream<UserModel> getUserStream() async* {
    final userDoc = _store.collection("users").doc(user!.uid).snapshots();
    yield* userDoc.map((doc) {
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      } else {
        throw Future.error('User document does not exist');
      }
    });
  }

  Future getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (user != null) {
      await _store
          .collection('users')
          .doc(user?.uid)
          .update({'fcmToken': fcmToken});
      Print.warning(user?.uid);
      final info = await storeInfo.get();
      Print.error(fcmToken, 'hello');
      Print.error(info, 'info');
    }
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

  Future<void> deleteImage(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(imagePath);
      await ref.delete();
    } catch (e) {
      throw Exception('Error deleting image: $e');
    }
  }

  Future createProfile({
    List<String>? profileImages,
    String? firstName,
    String? lastName,
    String? gender,
    String? birthDate,
    String? location,
    List<String>? hobiesAndInterests,
    String? interestedGender,
    List<String>? lookingFor,
    String? sexualOrientation,
    String? about,
    bool? isAdmin,
  }) async {
    if (user != null) {
      final currentPosition = await _locationService.determinePosition();
      final currentLocation = {
        'latitude': currentPosition.latitude,
        'longitude': currentPosition.longitude,
      };
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
        "lookingFor": lookingFor ?? [],
        "sexualOrientation": sexualOrientation ?? '',
        "about": about ?? '',
        "isAdmin": false, //For admin account
        "currentLocation": currentLocation,
        "subscription": false,
        //For no subs its false it will turn true when its subscribed
        "isValidated": false,
        "canRecieveImages": false,
        "canRecieveAudios": false,
        "canRecieveVideos": false,
      });
    }
  }

  Future editProfile({
    List<String>? profileImages,
    String? firstName,
    String? lastName,
    String? gender,
    String? birthDate,
    String? location,
    List<String>? hobiesAndInterests,
    String? interestedGender,
    List<String>? lookingFor,
    String? sexualOrientation,
    String? about,
  }) async {
    if (user != null) {
      if (user!.displayName != '$firstName $lastName') {
        await user!.updateDisplayName('$firstName $lastName');
      }
      await storeInfo.update({
        "firstName": firstName ?? '',
        "lastName": lastName ?? '',
        "profileImages": profileImages ?? [],
        "gender": gender ?? '',
        "birthDate": birthDate ?? '',
        "location": location ?? '',
        "hobiesAndInterests": hobiesAndInterests ?? [],
        "interestedGender": interestedGender ?? '',
        "lookingFor": lookingFor ?? [],
        "sexualOrientation": sexualOrientation ?? '',
        "about": about ?? '',
      });
    }
  }

  Stream<List<UserModel>> getProfilesStream() async* {
    final usersProfileList = <UserModel>[];
    final likedUserIds = <String>[];

    if (user != null) {
      final likedListSnapshot = await _store
          .collection('users')
          .doc(user!.uid)
          .collection('likedList')
          .get();

      for (var doc in likedListSnapshot.docs) {
        likedUserIds.add(doc.id);
      }

      final usersProfilesQuery =
          _store.collection('users').where('uid', isNotEqualTo: user!.uid);

      final usersProfilesSnapshot = usersProfilesQuery.snapshots();

      await for (var snapshot in usersProfilesSnapshot) {
        final usersProfiles = snapshot.docs;

        for (var doc in usersProfiles) {
          if (!likedUserIds.contains(doc.id)) {
            usersProfileList.add(UserModel.fromJson(doc.data()));
          }
        }

        yield usersProfileList;
      }
    } else {
      yield usersProfileList;
    }
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
      rethrow;
    } catch (e) {
      Print.error("Unexpected error during registration: $e");
      if (context.mounted) {
        Utils.show.toast(context, e.toString());
      }
      rethrow;
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

  Future<void> deleteAccount() async {
    await _store.collection("users").doc(_auth.currentUser?.uid).delete();
    await _auth.currentUser?.delete();
    await logout();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
