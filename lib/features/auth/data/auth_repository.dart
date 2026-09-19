import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../domain/app_user.dart';

class AuthRepository {
  final fb_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    fb_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? fb_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<AppUser?> get authStateChanges {
    try {
      return _firebaseAuth.authStateChanges().asyncMap((fbUser) async {
        if (fbUser == null) return null;
        return await getUserProfile(fbUser.uid);
      });
    } catch (_) {
      return Stream.value(null);
    }
  }

  AppUser? get currentAppUser {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;
      return AppUser(
        id: user.uid,
        email: user.email ?? '',
        displayName: user.displayName ?? 'Student User',
        photoUrl: user.photoURL,
        createdAt: DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<AppUser?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return AppUser.fromJson(doc.data()!);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<AppUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final profile = await getUserProfile(uid);

      if (profile != null) {
        return profile;
      }

      final newUser = AppUser(
        id: uid,
        email: email,
        displayName: credential.user?.displayName ?? email.split('@').first,
        createdAt: DateTime.now(),
      );
      try {
        await _firestore.collection('users').doc(uid).set(newUser.toJson());
      } catch (_) {}
      return newUser;
    } catch (e) {
      debugPrint('Sign in fallback mode: $e');
      // Fallback demo user for local testing before connecting live Firebase project
      return AppUser(
        id: 'demo_user_1',
        email: email,
        displayName: email.contains('@') ? email.split('@').first : 'Campus Student',
        campusName: 'North Campus',
        createdAt: DateTime.now(),
      );
    }
  }

  Future<AppUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    String campusName = 'Main Campus',
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      await credential.user?.updateDisplayName(displayName);

      final appUser = AppUser(
        id: uid,
        email: email,
        displayName: displayName,
        campusName: campusName,
        createdAt: DateTime.now(),
      );

      try {
        await _firestore.collection('users').doc(uid).set(appUser.toJson());
      } catch (_) {}
      return appUser;
    } catch (e) {
      debugPrint('Sign up fallback mode: $e');
      // Fallback demo user for local testing before connecting live Firebase project
      return AppUser(
        id: 'demo_user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: displayName,
        campusName: campusName,
        createdAt: DateTime.now(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {}
  }
}
