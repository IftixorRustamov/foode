part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUpEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignOutEvent extends AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class AuthSignInAnonymouslyEvent extends AuthEvent {}

/// Event triggered when an authenticated user is received (internal bloc event).
class AuthUserChangedEvent extends AuthEvent {
  final UserEntity? user;

  const AuthUserChangedEvent(this.user);

  @override
  List<Object?> get props => [user];
}
