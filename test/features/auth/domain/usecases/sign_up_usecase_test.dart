import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';
import 'package:uic_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:uic_task/features/auth/domain/usecases/sign_up_usecase.dart';

import 'sign_up_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignUpUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignUpUseCase(mockAuthRepository);
  });

  final tEmail = 'test@example.com';
  final tPassword = 'password123';
  final tUser = UserEntity(uid: '1', email: tEmail, name: 'Test User');

  test('should return UserEntity when sign up is successful', () async {
    when(mockAuthRepository.signUpWithEmailAndPassword(
      email: tEmail,
      password: tPassword,
    )).thenAnswer((_) async => Right(tUser));

    final result = await useCase(SignUpParams(email: tEmail, password: tPassword));

    expect(result, Right(tUser));
    verify(mockAuthRepository.signUpWithEmailAndPassword(
      email: tEmail,
      password: tPassword,
    )).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when sign up fails', () async {
    when(mockAuthRepository.signUpWithEmailAndPassword(
      email: tEmail,
      password: tPassword,
    )).thenAnswer((_) async => const Left(AuthFailure(message: 'email-already-in-use')));

    final result = await useCase(SignUpParams(email: tEmail, password: tPassword));

    expect(result, const Left(AuthFailure(message: 'email-already-in-use')));
    verify(mockAuthRepository.signUpWithEmailAndPassword(
      email: tEmail,
      password: tPassword,
    )).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
} 