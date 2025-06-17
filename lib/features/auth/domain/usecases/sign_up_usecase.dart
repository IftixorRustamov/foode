import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/core/usecases/usecase.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';
import 'package:uic_task/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;

  const SignUpParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
