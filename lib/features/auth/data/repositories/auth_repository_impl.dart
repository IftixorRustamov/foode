import 'package:firebase_auth/firebase_auth.dart'; // Hide User to avoid conflict with our UserEntity
import 'package:dartz/dartz.dart';
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';
import 'package:uic_task/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  // Helper to map Firebase User to UserEntity
  UserEntity? _mapFirebaseUserToEntity(User? firebaseUser) {
    return firebaseUser != null
        ? UserEntity(
            uid: firebaseUser.uid,
            email: firebaseUser.email,
            name: firebaseUser.displayName,
          )
        : null;
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userEntity = _mapFirebaseUserToEntity(userCredential.user);
      if (userEntity != null) {
        return Right(userEntity);
      } else {
        return const Left(
          AuthFailure(message: 'Sign in failed: No user data.'),
        );
      }
    } on Failure catch (e) {
      // Data source throws custom Failure directly, so just propagate
      return Left(e);
    } catch (e) {
      // Catch any unexpected non-Failure exceptions
      return const Left(
        UnknownFailure(message: 'An unexpected error occurred during sign-in.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userEntity = _mapFirebaseUserToEntity(userCredential.user);
      if (userEntity != null) {
        return Right(userEntity);
      } else {
        return const Left(
          AuthFailure(message: 'Sign up failed: No user data.'),
        );
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(
        UnknownFailure(message: 'An unexpected error occurred during sign-up.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInAnonymously() async {
    try {
      final userCredential = await remoteDataSource.signInAnonymously();
      final userEntity = _mapFirebaseUserToEntity(userCredential.user);
      if (userEntity != null) {
        return Right(userEntity);
      } else {
        return const Left(
          AuthFailure(message: 'Anonymous sign-in failed: No user data.'),
        );
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(
        UnknownFailure(
          message: 'An unexpected error occurred during anonymous sign-in.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(unit);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(
        UnknownFailure(
          message: 'An unexpected error occurred during sign-out.',
        ),
      );
    }
  }

  @override
  Stream<UserEntity?> getCurrentUser() {
    return remoteDataSource.firebaseUser.map(_mapFirebaseUserToEntity);
  }
}
