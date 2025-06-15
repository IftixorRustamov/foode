import 'package:get_it/get_it.dart';

import 'core/database/hive_initializer.dart';
import 'core/network/dio_client.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerSingleton<HiveInitializer>(HiveInitializer());
  // sl.registerLazySingleton<TokenStorage>(() => TokenStorage());

  // Core
  sl.registerSingleton<DioClient>(DioClient());
  // sl.registerSingleton<AppTextStyles>(UrbanistTextStyles());
  // sl.registerSingleton<UrbanistTextStyles>(UrbanistTextStyles());
}
