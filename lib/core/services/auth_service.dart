import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
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

  Future<String> uploadImage({pickedFile}) async {
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
    String? sex,
    String? birthDate,
    String? location,
    List<String>? hobiesAndInterests,
    String? relationship,
    String? relationshipSex,
  }) async {
    if (user != null) {
      _auth.currentUser?.updateDisplayName(firstName);

      storeInfo.set({
        "profileImages": profileImages ?? [],
        "firstName": firstName ?? '',
        "lastName": lastName ?? '',
        "sex": sex ?? '',
        "birthDate": birthDate ?? '',
        "location": location ?? '',
        "hobiesAndInterests": hobiesAndInterests ?? [],
        "relationship": relationship ?? '',
        "relationshipSex": relationshipSex ?? '',
      });
    }
  }

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      final createdUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _store.collection('users').doc(createdUser.user?.uid).set({
        "email": email,
      });

      return createdUser;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> forgotPw(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // TODO: Future<void> updatePassword(
  //     String currentPassword, String newPassword) async {
  //   try {
  //     await _auth.currentUser?.reauthenticateWithCredential(
  //         const AuthCredential(
  //             providerId: 'google.com', signInMethod: 'password'));

  //     await _auth.currentUser?.updatePassword(newPassword);
  //   } on FirebaseAuthException {
  //     rethrow;
  //   }
  // }

  Future<void> deleteAccount(String email) async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
