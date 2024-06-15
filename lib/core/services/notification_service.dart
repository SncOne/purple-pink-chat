//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationService = Provider((_) => NotificationService());

class NotificationService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  //FirebaseFirestore get _store => FirebaseFirestore.instance;

  User? get user => _auth.currentUser;
}
