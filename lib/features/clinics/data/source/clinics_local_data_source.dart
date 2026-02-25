import 'dart:convert';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/error_model.dart';
import 'package:beautygm/features/clinics/data/models/clinic_model.dart';

class ClinicsLocalDataSource {
  final CacheHelper cache;
  final String key = "cachedClinics";

  ClinicsLocalDataSource({required this.cache});

  Future<void> cacheClinics(List<ClinicModel>? clinicsToCache) async {
    try {
      final jsonList = clinicsToCache?.map((e) => e.toString()).toList();

      final jsonString = jsonEncode(jsonList);

      final success = await cache.save(key, jsonString);

      if (!success) {
        throw const CacheWriteException(
            ErrorModel(errorMessage: "Failed to cache posts"));
      }
    } catch (_) {
      throw const CacheWriteException(
        ErrorModel(errorMessage: "Failed to cache posts"),
      );
    }
  }

  Future<List<ClinicModel>> getLastClinics() async {
    try {
      final jsonString = cache.get(key);

      if (jsonString == null) {
        throw const CacheReadException(
          ErrorModel(errorMessage: "No cached posts found"),
        );
      }

      final List decoded = jsonDecode(jsonString);

      return decoded
          .map((e) => ClinicModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      throw const CacheReadException(
        ErrorModel(errorMessage: "Failed to read cached posts"),
      );
    }
  }
}
