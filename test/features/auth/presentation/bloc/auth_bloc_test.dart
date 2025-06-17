// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:uic_task/core/exceptions/failure.dart';
// import 'package:uic_task/features/auth/domain/entities/user_entity.dart';
// import 'package:uic_task/features/auth/domain/repositories/auth_repository.dart';
// import 'package:uic_task/features/auth/domain/usecases/sign_in_usecase.dart';
// import 'package:uic_task/features/auth/domain/usecases/sign_up_usecase.dart';
// import 'package:uic_task/features/auth/presentation/bloc/auth_bloc.dart';
//
// import 'auth_bloc_test.mocks.dart';
//
// @GenerateMocks([SignInUseCase, SignUpUseCase, AuthRepository])
// void main() {
//   late AuthBloc authBloc;
//   late MockSignInUseCase mockSignInUseCase;
//   late MockSignUpUseCase mockSignUpUseCase;
//   late MockAuthRepository mockAuthRepository;
//
//   setUp(() {
//     mockSignInUseCase = MockSignInUseCase();
//     mockSignUpUseCase = MockSignUpUseCase();
//     mockAuthRepository = MockAuthRepository();
//     mockSignInAnonymously = MockI
//
//     when(
//       mockAuthRepository.getCurrentUser(),
//     ).thenAnswer((_) => Stream.fromIterable([null])); // Initially no user
//     authBloc = AuthBloc(
//       signInUseCase: mockSignInUseCase,
//       signUpUseCase: mockSignUpUseCase,
//       authRepository: mockAuthRepository,
//       signInAnonymouslyUseCase: null,
//     );
//   });
//
//   tearDown(() {
//     authBloc.close();
//   });
//
//   final tUser = UserEntity(
//     uid: '123',
//     email: 'test@example.com',
//     name: 'Test User',
//   );
//   const tEmail = 'test@example.com';
//   const tPassword = 'password123';
//   const tAuthFailure = AuthFailure(message: 'Invalid credentials');
//   const tNetworkFailure = NetworkFailure(message: 'No internet');
//
//   group('AuthSignInEvent', () {
//     blocTest<AuthBloc, AuthState>(
//       'should emit [AuthLoading, AuthAuthenticated] when signIn is successful',
//       build: () {
//         when(mockSignInUseCase(any)).thenAnswer((_) async => Right(tUser));
//         return authBloc;
//       },
//       act: (bloc) =>
//           bloc.add(const AuthSignInEvent(email: tEmail, password: tPassword)),
//       expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
//       verify: (_) {
//         verify(
//           mockSignInUseCase(
//             const SignInParams(email: tEmail, password: tPassword),
//           ),
//         ).called(1);
//       },
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'should emit [AuthLoading, AuthError] when signIn fails',
//       build: () {
//         when(
//           mockSignInUseCase(any),
//         ).thenAnswer((_) async => const Left(tAuthFailure));
//         return authBloc;
//       },
//       act: (bloc) =>
//           bloc.add(const AuthSignInEvent(email: tEmail, password: tPassword)),
//       expect: () => [
//         AuthLoading(),
//         const AuthError(
//           message: 'Invalid credentials. Please check your email and password.',
//         ),
//       ],
//       verify: (_) {
//         verify(
//           mockSignInUseCase(
//             const SignInParams(email: tEmail, password: tPassword),
//           ),
//         ).called(1);
//       },
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'should emit [AuthLoading, AuthError] when signIn fails due to network',
//       build: () {
//         when(
//           mockSignInUseCase(any),
//         ).thenAnswer((_) async => const Left(tNetworkFailure));
//         return authBloc;
//       },
//       act: (bloc) =>
//           bloc.add(const AuthSignInEvent(email: tEmail, password: tPassword)),
//       expect: () => [
//         AuthLoading(),
//         const AuthError(
//           message: 'No internet connection. Please check your network.',
//         ),
//       ],
//       verify: (_) {
//         verify(
//           mockSignInUseCase(
//             const SignInParams(email: tEmail, password: tPassword),
//           ),
//         ).called(1);
//       },
//     );
//   });
//
//   group('AuthSignUpEvent', () {
//     blocTest<AuthBloc, AuthState>(
//       'should emit [AuthLoading, AuthAuthenticated] when signUp is successful',
//       build: () {
//         when(mockSignUpUseCase(any)).thenAnswer((_) async => Right(tUser));
//         return authBloc;
//       },
//       act: (bloc) =>
//           bloc.add(const AuthSignUpEvent(email: tEmail, password: tPassword)),
//       expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
//       verify: (_) {
//         verify(
//           mockSignUpUseCase(
//             const SignUpParams(email: tEmail, password: tPassword),
//           ),
//         ).called(1);
//       },
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'should emit [AuthLoading, AuthError] when signUp fails',
//       build: () {
//         when(
//           mockSignUpUseCase(any),
//         ).thenAnswer((_) async => const Left(tAuthFailure));
//         return authBloc;
//       },
//       act: (bloc) =>
//           bloc.add(const AuthSignUpEvent(email: tEmail, password: tPassword)),
//       expect: () => [
//         AuthLoading(),
//         const AuthError(
//           message: 'Invalid credentials. Please check your email and password.',
//         ),
//       ],
//       verify: (_) {
//         verify(
//           mockSignUpUseCase(
//             const SignUpParams(email: tEmail, password: tPassword),
//           ),
//         ).called(1);
//       },
//     );
//   });
//
//   group('AuthSignOutEvent', () {
//     blocTest<AuthBloc, AuthState>(
//       'should emit [AuthUnauthenticated] when signOut is successful',
//       build: () {
//         when(
//           mockAuthRepository.signOut(),
//         ).thenAnswer((_) async => const Right(unit));
//         return authBloc;
//       },
//       act: (bloc) => bloc.add(AuthSignOutEvent()),
//       expect: () => [AuthUnauthenticated()],
//       verify: (_) {
//         verify(mockAuthRepository.signOut()).called(1);
//       },
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'should emit [AuthError] when signOut fails',
//       build: () {
//         when(
//           mockAuthRepository.signOut(),
//         ).thenAnswer((_) async => const Left(tAuthFailure));
//         return authBloc;
//       },
//       act: (bloc) => bloc.add(AuthSignOutEvent()),
//       expect: () => [
//         const AuthError(
//           message: 'Invalid credentials. Please check your email and password.',
//         ),
//       ],
//       verify: (_) {
//         verify(mockAuthRepository.signOut()).called(1);
//       },
//     );
//   });
//
//   group('AuthUserChangedEvent', () {
//     blocTest<AuthBloc, AuthState>(
//       'should emit AuthAuthenticated when user is not null',
//       build: () => authBloc,
//       act: (bloc) => bloc.add(AuthUserChangedEvent(tUser)),
//       expect: () => [AuthAuthenticated(user: tUser)],
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'should emit AuthUnauthenticated when user is null',
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const AuthUserChangedEvent(null)),
//       expect: () => [AuthUnauthenticated()],
//     );
//   });
// }
