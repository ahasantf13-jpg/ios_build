import 'package:dio/dio.dart';
import 'package:beautygm/core/databases/api/api_consumer.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';

class DeleteAccountRemoteDataSource {
  final ApiConsumer api;

  DeleteAccountRemoteDataSource({required this.api});

  Future<void> deleteAccount(DeleteAccountParams params) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    await api.delete(EndPoints.deleteAccount,
        options: Options(headers: {"Authorization": "Bearer $accessKey"}),
        data: {
          "email": params.email,
          "password": params.password,
        });
  }
}
