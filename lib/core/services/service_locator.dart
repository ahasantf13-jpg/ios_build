import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/databases/api/dio_consumer.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  getIt.registerLazySingleton<CacheHelper>(
    () => CacheHelper(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );

  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => DioConsumer(dio: getIt<Dio>()));
}
