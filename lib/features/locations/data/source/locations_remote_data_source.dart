import 'package:beautygm/core/databases/api/api_consumer.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/locations/data/models/locations_model.dart';
import 'package:dio/dio.dart';

class LocationsRemoteDataSource {
  final ApiConsumer api;

  LocationsRemoteDataSource({required this.api});

  Future<List<LocationsModel>> getAllLocations() async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    final response = await api.get(
      EndPoints.getAllLocations,
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
    );

    final List data = response as List;

    return data.map((json) => LocationsModel.fromJson(json)).toList();
  }

  Future<void> addNewLocation(AddLocationParams params) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);
    await api.post(EndPoints.getAllLocations,
        options: Options(headers: {"Authorization": "Bearer $accessKey"}),
        data: {
          "label": params.label,
          "floor": params.floor,
          "address": params.address,
          "flat": params.flat,
          "phone_number": params.phoneNumber,
          "is_default": params.isDefault
        });
  }

  Future<void> deleteLocation(DeleteLocationParams params) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    final String path = "${EndPoints.getAllLocations}/${params.locationId}";

    await api.delete(path,
        options: Options(headers: {"Authorization": "Bearer $accessKey"}));
  }
}
