import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/exceptions/failure.dart';
import 'package:uic_task/features/auth/domain/entities/user_entity.dart';
import 'package:uic_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:uic_task/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import 'dart:async';
import 'package:uic_task/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:uic_task/features/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final AuthRepository _authRepository;
  final SignInAnonymouslyUseCase _signInAnonymouslyUseCase;

  StreamSubscription<UserEntity?>? _userSubscription;

  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required AuthRepository authRepository,
    required SignInAnonymouslyUseCase signInAnonymouslyUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _authRepository = authRepository,
       _signInAnonymouslyUseCase = signInAnonymouslyUseCase,
       super(AuthInitial()) {
    on<AuthSignInEvent>(_onSignIn);
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthSignOutEvent>(_onSignOut);
    on<AuthCheckStatusEvent>(_onCheckStatus);
    on<AuthUserChangedEvent>(_onUserChanged);
    on<AuthSignInAnonymouslyEvent>(_onSignInAnonymously);
    on<AuthUpdateBioEvent>(_onUpdateBio);

    // Listen to auth state changes from the repository
    _userSubscription = _authRepository.getCurrentUser().listen(
      (user) => add(AuthUserChangedEvent(user)),
    );
  }

  Future<void> _onSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signInUseCase(
      SignInParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) {
        emit(AuthError(message: _mapFailureToMessage(failure)));
      },
      (user) {
        emit(AuthAuthenticated(user: user));
      },
    );
  }

  Future<void> _onSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signUpUseCase(
      SignUpParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onSignOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.signOut();
    result.fold(
      (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onSignInAnonymously(
    AuthSignInAnonymouslyEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _signInAnonymouslyUseCase();
    result.fold(
      (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onCheckStatus(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    // This event primarily relies on the _userSubscription
    // and AuthUserChangedEvent to update the state
    // If the stream hasn't emitted yet, or if it's the initial state,
    // we might still be in AuthInitial.
    // The first emission from _userSubscription will drive the state change.
    if (state is AuthInitial) {
      // Optional: You could emit AuthLoading here if you have a splash screen
      // that needs to explicitly show a loading state while checking
      // initial auth status.
    }
  }

  void _onUserChanged(AuthUserChangedEvent event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthAuthenticated(user: event.user!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onUpdateBio(
    AuthUpdateBioEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _authRepository.updateUserBio(
      uid: event.uid,
      fullName: event.fullName,
      nickName: event.nickName,
      phoneNumber: event.phoneNumber,
      gender: event.gender,
      dateOfBirth: event.dateOfBirth,
      address: event.address,
    );
    result.fold(
      (failure) {
        emit(AuthError(message: _mapFailureToMessage(failure)));
      },
      (_) {
        emit(const AuthBioUpdated());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    final msg = failure.message?.toLowerCase() ?? '';
    if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network and try again.';
    }
    if (failure is ServerFailure) {
      return 'A server error occurred. Please try again later.';
    }
    if (msg.contains('invalid credentials')) {
      return 'Incorrect email or password. Please try again.';
    }
    if (msg.contains('already in use') ||
        msg.contains('email-already-in-use')) {
      return 'This email is already registered. Please use another email or sign in.';
    }
    if (msg.contains('too weak')) {
      return 'Your password is too weak. Please use a stronger password.';
    }
    if (msg.contains('disabled')) {
      return 'This account has been disabled. Please contact support.';
    }
    if (msg.contains('not enabled')) {
      return 'Email/password sign-in is not enabled. Please contact support.';
    }
    if (msg.contains('authentication failed')) {
      return 'Authentication failed. Please check your credentials.';
    }
    return failure.message ?? 'An unexpected error occurred. Please try again.';
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
