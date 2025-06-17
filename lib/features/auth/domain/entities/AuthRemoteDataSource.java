import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class for remote authentication operations.
abstract class AuthRemoteDataSource {
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> signInAnonymously();

  Future<void> signOut();

  Stream<User?> get firebaseUser;
}