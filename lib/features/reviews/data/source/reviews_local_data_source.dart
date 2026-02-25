import 'dart:convert';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/error_model.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/reviews/data/models/reviews_model.dart';

class ReviewsLocalDataSource {
  CacheHelper cache = getIt<CacheHelper>();
  final String key = "cachedReviews";

  ReviewsLocalDataSource({required this.cache});

  void cacheReviews(List<ReviewsModel> reviewssToCache) async {
    try {
      final jsonList = reviewssToCache.map((e) => e.toJson()).toList();

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

  Future<List<ReviewsModel>> getLastReviews() async {
    try {
      final jsonString = cache.get<String>(key);

      if (jsonString == null) {
        throw const CacheReadException(
          ErrorModel(errorMessage: "No cached posts found"),
        );
      }

      final List decoded = jsonDecode(jsonString);

      return decoded
          .map((e) => ReviewsModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      throw const CacheReadException(
        ErrorModel(errorMessage: "Failed to read cached posts"),
      );
    }
  }
}
