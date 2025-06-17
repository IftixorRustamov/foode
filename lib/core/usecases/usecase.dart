import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uic_task/core/exceptions/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
