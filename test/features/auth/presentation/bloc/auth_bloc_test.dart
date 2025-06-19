import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';
import 'package:uic_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:uic_task/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:uic_task/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:uic_task/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import 'package:uic_task/features/auth/presentation/bloc/auth_bloc.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([
  SignInUseCase,
  SignUpUseCase,
  AuthRepository,
  SignInAnonymouslyUseCase,
])
void main() {
  late AuthBloc authBloc;
  late MockSignInUseCase mockSignInUseCase;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockAuthRepository mockAuthRepository;
  late MockSignInAnonymouslyUseCase mockSignInAnonymouslyUseCase;

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    mockAuthRepository = MockAuthRepository();
    mockSignInAnonymouslyUseCase = MockSignInAnonymouslyUseCase();

    when(
      mockAuthRepository.getCurrentUser(),
    ).thenAnswer((_) => Stream.fromIterable([null]));
    authBloc = AuthBloc(
      signInUseCase: mockSignInUseCase,
      signUpUseCase: mockSignUpUseCase,
      authRepository: mockAuthRepository,
      signInAnonymouslyUseCase: mockSignInAnonymouslyUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  final tUser = UserEntity(
    uid: '123',
    email: 'test@example.com',
    name: 'Test User',
  );
  const tEmail = 'test@example.com';
  const tPassword = 'password123';

  group('AuthSignInEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when sign in succeeds',
      build: () {
        when(mockSignInUseCase(any)).thenAnswer((_) async => Right(tUser));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthSignInEvent(email: tEmail, password: tPassword)),
      expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when sign in fails with invalid credentials',
      build: () {
        when(mockSignInUseCase(any)).thenAnswer(
          (_) async => const Left(AuthFailure(message: 'Invalid credentials')),
        );
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthSignInEvent(email: tEmail, password: tPassword)),
      expect: () => [
        AuthLoading(),
        const AuthError(
          message: 'Incorrect email or password. Please try again.',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when sign in fails due to network',
      build: () {
        when(mockSignInUseCase(any)).thenAnswer(
          (_) async => const Left(NetworkFailure(message: 'No internet')),
        );
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthSignInEvent(email: tEmail, password: tPassword)),
      expect: () => [
        AuthLoading(),
        const AuthError(
          message:
              'No internet connection. Please check your network and try again.',
        ),
      ],
    );
  });

  group('AuthSignUpEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when sign up succeeds',
      build: () {
        when(mockSignUpUseCase(any)).thenAnswer((_) async => Right(tUser));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthSignUpEvent(email: tEmail, password: tPassword)),
      expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when sign up fails with email already in use',
      build: () {
        when(mockSignUpUseCase(any)).thenAnswer(
          (_) async => const Left(AuthFailure(message: 'email-already-in-use')),
        );
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthSignUpEvent(email: tEmail, password: tPassword)),
      expect: () => [
        AuthLoading(),
        const AuthError(
          message:
              'This email is already registered. Please use another email or sign in.',
        ),
      ],
    );
  });
}
