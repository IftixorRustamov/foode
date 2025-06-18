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
  List<Object?> get props => [email, password];
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUpEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthUpdateBioEvent extends AuthEvent {
  final String uid;
  final String fullName;
  final String nickName;
  final String phoneNumber;
  final String gender;
  final DateTime dateOfBirth;
  final String address;

  const AuthUpdateBioEvent({
    required this.uid,
    required this.fullName,
    required this.nickName,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.address,
  });

  @override
  List<Object?> get props => [
    uid,
    fullName,
    nickName,
    phoneNumber,
    gender,
    dateOfBirth,
    address,
  ];
}

class AuthSignOutEvent extends AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class AuthSignInAnonymouslyEvent extends AuthEvent {}

class AuthUserChangedEvent extends AuthEvent {
  final UserEntity? user;

  const AuthUserChangedEvent(this.user);

  @override
  List<Object?> get props => [user];
}
