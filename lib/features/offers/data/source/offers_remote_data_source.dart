import 'package:beautygm/core/databases/api/api_consumer.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/offers/data/models/get_all_offer_model.dart';
import 'package:dio/dio.dart';

class OffersRemoteDataSource {
  final ApiConsumer api;

  OffersRemoteDataSource({required this.api});

  Future<void> createNewOffer(CreateOffersParams params) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    final data = FormData.fromMap({
      "cid": params.clinicID,
      "category": params.categories,
      "start_date": params.startDay,
      "end_date": params.endDay,
      "is_hidden": params.isHidden,
      "image": await MultipartFile.fromFile(
        params.offerBanner.path,
        filename: params.offerBanner.path.split('/').last,
      ),
    });

    await api.post(
      EndPoints.createNewOffer,
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
      data: data,
    );
  }

  Future<List<GetAllOfferModel>> getAllOffers() async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    final response = await api.get(
      EndPoints.getAllOffers,
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
    );

    final List data = response as List;

    return data.map((json) => GetAllOfferModel.fromJson(json)).toList();
  }

  Future<void> adminApproveRejectOffer(
    AdminApproveRejectOffersParams params,
  ) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    await api.patch(
      "${EndPoints.getAllOffers}${params.offerID}/manage/",
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
      data: {"status": params.action},
    );
  }
}
