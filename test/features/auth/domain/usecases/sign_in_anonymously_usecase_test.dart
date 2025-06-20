import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';
import 'package:uic_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:uic_task/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';

import 'sign_in_anonymously_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignInAnonymouslyUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignInAnonymouslyUseCase(mockAuthRepository);
  });

  final tUser = UserEntity(uid: '1', email: 'anon@example.com', name: 'Anon');

  test('should return UserEntity when anonymous sign in is successful', () async {
    when(mockAuthRepository.signInAnonymously())
        .thenAnswer((_) async => Right(tUser));

    final result = await useCase();

    expect(result, Right(tUser));
    verify(mockAuthRepository.signInAnonymously()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when anonymous sign in fails', () async {
    when(mockAuthRepository.signInAnonymously())
        .thenAnswer((_) async => const Left(AuthFailure(message: 'Anonymous sign-in failed')));

    final result = await useCase();

    expect(result, const Left(AuthFailure(message: 'Anonymous sign-in failed')));
    verify(mockAuthRepository.signInAnonymously()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
} 