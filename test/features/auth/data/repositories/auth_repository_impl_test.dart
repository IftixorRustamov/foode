import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:uic_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, fb.UserCredential, fb.User])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockUserCredential mockUserCredential;
  late MockUser mockFirebaseUser;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockUserCredential = MockUserCredential();
    mockFirebaseUser = MockUser();
    repository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUid = 'abc123';
  final tUserEntity = UserEntity(uid: tUid, email: tEmail, name: 'Test User');

  void stubFirebaseUser() {
    when(mockUserCredential.user).thenReturn(mockFirebaseUser);
    when(mockFirebaseUser.uid).thenReturn(tUid);
    when(mockFirebaseUser.email).thenReturn(tEmail);
    when(mockFirebaseUser.displayName).thenReturn('Test User');
  }

  group('signInWithEmailAndPassword', () {
    test('returns UserEntity on success', () async {
      stubFirebaseUser();
      when(mockRemoteDataSource.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      )).thenAnswer((_) async => mockUserCredential);

      final result = await repository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      expect(result, Right(tUserEntity));
    });

    test('returns Failure on custom failure', () async {
      when(mockRemoteDataSource.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      )).thenThrow(const AuthFailure(message: 'Invalid credentials'));

      final result = await repository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      expect(result, const Left(AuthFailure(message: 'Invalid credentials')));
    });

    test('returns Failure on unknown error', () async {
      when(mockRemoteDataSource.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      )).thenThrow(Exception('unexpected'));

      final result = await repository.signInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      expect(result, isA<Left>());
    });
  });

  group('signUpWithEmailAndPassword', () {
    test('returns UserEntity on success', () async {
      stubFirebaseUser();
      when(mockRemoteDataSource.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      )).thenAnswer((_) async => mockUserCredential);

      final result = await repository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      expect(result, Right(tUserEntity));
    });

    test('returns Failure on custom failure', () async {
      when(mockRemoteDataSource.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      )).thenThrow(const AuthFailure(message: 'email-already-in-use'));

      final result = await repository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      );

      expect(result, const Left(AuthFailure(message: 'email-already-in-use')));
    });
  });

  group('signInAnonymously', () {
    test('returns UserEntity on success', () async {
      stubFirebaseUser();
      when(mockRemoteDataSource.signInAnonymously())
          .thenAnswer((_) async => mockUserCredential);

      final result = await repository.signInAnonymously();

      expect(result, Right(tUserEntity));
    });

    test('returns Failure on custom failure', () async {
      when(mockRemoteDataSource.signInAnonymously())
          .thenThrow(const AuthFailure(message: 'Anonymous sign-in failed'));

      final result = await repository.signInAnonymously();

      expect(result, const Left(AuthFailure(message: 'Anonymous sign-in failed')));
    });
  });

  group('signOut', () {
    test('returns unit on success', () async {
      when(mockRemoteDataSource.signOut()).thenAnswer((_) async => null);

      final result = await repository.signOut();

      expect(result, const Right(unit));
    });

    test('returns Failure on custom failure', () async {
      when(mockRemoteDataSource.signOut())
          .thenThrow(const AuthFailure(message: 'Sign out failed'));

      final result = await repository.signOut();

      expect(result, const Left(AuthFailure(message: 'Sign out failed')));
    });
  });

  group('updateUserBio', () {
    test('returns unit on success', () async {
      when(mockRemoteDataSource.updateUserBio(
        uid: tUid,
        fullName: 'Test User',
        nickName: 'T',
        phoneNumber: '123',
        gender: 'M',
        dateOfBirth: DateTime(2000, 1, 1),
        address: 'Address',
      )).thenAnswer((_) async => null);

      final result = await repository.updateUserBio(
        uid: tUid,
        fullName: 'Test User',
        nickName: 'T',
        phoneNumber: '123',
        gender: 'M',
        dateOfBirth: DateTime(2000, 1, 1),
        address: 'Address',
      );

      expect(result, const Right(unit));
    });

    test('returns Failure on custom failure', () async {
      when(mockRemoteDataSource.updateUserBio(
        uid: tUid,
        fullName: 'Test User',
        nickName: 'T',
        phoneNumber: '123',
        gender: 'M',
        dateOfBirth: DateTime(2000, 1, 1),
        address: 'Address',
      )).thenThrow(const AuthFailure(message: 'Update bio failed'));

      final result = await repository.updateUserBio(
        uid: tUid,
        fullName: 'Test User',
        nickName: 'T',
        phoneNumber: '123',
        gender: 'M',
        dateOfBirth: DateTime(2000, 1, 1),
        address: 'Address',
      );

      expect(result, const Left(AuthFailure(message: 'Update bio failed')));
    });
  });
} 