import 'dart:convert';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/error_model.dart';
import 'package:beautygm/features/locations/data/models/locations_model.dart';

class LocationsLocalDataSource {
  CacheHelper cache;
  final String key = "cachedLocations";

  LocationsLocalDataSource({required this.cache});

  void cacheLocations(List<LocationsModel> locationsToCache) async {
    try {
      final jsonList = locationsToCache.map((e) => e.toJson()).toList();

      final jsonString = jsonEncode(jsonList);

      final success = await cache.save(key, jsonString);

      if (!success) {
        throw const CacheWriteException(
          ErrorModel(errorMessage: "Failed to cache posts"),
        );
      }
    } catch (_) {
      throw const CacheWriteException(
        ErrorModel(errorMessage: "Failed to cache posts"),
      );
    }
  }

  Future<List<LocationsModel>> getLastLocations() async {
    try {
      final jsonString = cache.get<String>(key);

      if (jsonString == null) {
        throw const CacheReadException(
          ErrorModel(errorMessage: "No cached posts found"),
        );
      }

      final List decoded = jsonDecode(jsonString);

      return decoded
          .map((e) => LocationsModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      throw const CacheReadException(
        ErrorModel(errorMessage: "Failed to read cached posts"),
      );
    }
  }
}
