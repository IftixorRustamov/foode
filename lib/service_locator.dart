import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/common/textstyles/source_san_textstyles.dart';
import 'package:uic_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:uic_task/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:uic_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:uic_task/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';

import 'core/database/hive_initializer.dart';
import 'core/network/dio_client.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerSingleton<HiveInitializer>(HiveInitializer());
  // sl.registerLazySingleton<TokenStorage>(() => TokenStorage());

  // Core
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<AppTextStyles>(SourceSanTextStyles());
  sl.registerSingleton<SourceSanTextStyles>(SourceSanTextStyles());


  //? External (Firebase instances)
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  //? Bloc
  sl.registerLazySingleton(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      authRepository: sl(),
      signInAnonymouslyUseCase: sl(),
    ),
  );

  //? Use Cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignInAnonymouslyUseCase(sl()));

  //? Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  //? Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl<FirebaseFirestore>()),
  );
}
