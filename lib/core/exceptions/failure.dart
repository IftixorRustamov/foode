import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final int? statusCode;

  const Failure({this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Represents a general server failure (e.g., 500 internal server error).
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server Error', super.statusCode});
}

/// Represents a failure related to network connectivity.
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No Internet Connection'});
}

/// Represents a failure where the requested resource was not found (e.g., 404).
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Resource Not Found',
    super.statusCode,
  });
}

/// Represents a failure due to invalid input data.
class InvalidInputFailure extends Failure {
  const InvalidInputFailure({super.message = 'Invalid Input'});
}

/// Represents a failure due to unauthorized access (e.g., 401).
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Unauthorized', super.statusCode});
}

/// Represents a failure during authentication (e.g., wrong credentials).
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication Failed',
    super.statusCode,
  });
}

/// Represents a general database failure (e.g., Hive, SQLite issues).
class DatabaseFailure extends Failure {
  const DatabaseFailure({super.message = 'Database Error'});
}

/// Represents a failure when an unknown error occurs.
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unexpected error occurred'});
}
