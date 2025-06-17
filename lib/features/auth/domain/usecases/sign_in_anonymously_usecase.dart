import 'package:dartz/dartz.dart';
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/core/usecases/usecase.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';
import 'package:uic_task/features/auth/domain/repositories/auth_repository.dart';

class SignInAnonymouslyUseCase implements NoParamsUseCase<UserEntity> {
  final AuthRepository repository;

  SignInAnonymouslyUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call() async {
    return await repository.signInAnonymously();
  }
}
