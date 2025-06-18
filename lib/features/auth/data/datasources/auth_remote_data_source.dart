import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> updateUserBio({
    required String uid,
    required String fullName,
    required String nickName,
    required String phoneNumber,
    required String gender,
    required DateTime dateOfBirth,
    required String address,
  });

  Stream<User?> get firebaseUser;
}
