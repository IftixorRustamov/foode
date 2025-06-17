import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/features/auth/data/datasources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Map FirebaseAuthException to a custom AuthFailure
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw const UnknownFailure(); // Catch any other unexpected errors
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'createdAt': Timestamp.now(),
          // Add other fields like 'name', 'photoUrl' if collected during signup
        });
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<UserCredential> signInAnonymously() async {
    try {
      return await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw const UnknownFailure();
    }
  }

  @override
  Stream<User?> get firebaseUser => _firebaseAuth.authStateChanges();

  // Helper method to map FirebaseAuthException codes to our custom Failures
  Failure _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-email':
        return AuthFailure(
          message: 'Invalid credentials. Please check your email and password.',
        );
      case 'email-already-in-use':
        return AuthFailure(
          message: 'The email address is already in use by another account.',
        );
      case 'weak-password':
        return AuthFailure(message: 'The password provided is too weak.');
      case 'operation-not-allowed':
        return AuthFailure(
          message: 'Signing in with Email and Password is not enabled.',
        );
      case 'network-request-failed':
        return const NetworkFailure();
      case 'user-disabled':
        return AuthFailure(message: 'This user account has been disabled.');
      default:
        return AuthFailure(
          message: e.message ?? 'An unexpected authentication error occurred.',
        );
    }
  }
}
