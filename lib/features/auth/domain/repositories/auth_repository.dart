import 'package:dartz/dartz.dart';
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signInAnonymously();

  Future<Either<Failure, Unit>> signOut();

  Future<Either<Failure, Unit>> updateUserBio({
    required String uid,
    required String fullName,
    required String nickName,
    required String phoneNumber,
    required String gender,
    required DateTime dateOfBirth,
    required String address,
  });

  Stream<UserEntity?> getCurrentUser();
}
