import 'dart:convert';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/error_model.dart';
import 'package:beautygm/features/profile/data/models/account_details_model.dart';

class AccountDetailsLocalDataSource {
  final CacheHelper cache;
  static const String key = "CachedAccountDetails";

  AccountDetailsLocalDataSource({required this.cache});

  void cacheAccountDetails(AccountDetailsModel accountDetailsToCache) async {
    try {
      final jsonList = accountDetailsToCache;

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

  /// GET
  Future<List<dynamic>> getLastAccountDetails() async {
    try {
      final jsonString = cache.get<String>(key);

      if (jsonString == null) {
        throw const CacheReadException(
          ErrorModel(errorMessage: "No cached posts found"),
        );
      }

      final List decoded = jsonDecode(jsonString);

      return decoded;
    } catch (_) {
      throw const CacheReadException(
        ErrorModel(errorMessage: "Failed to read cached posts"),
      );
    }
  }
}
