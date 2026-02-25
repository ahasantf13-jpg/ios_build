import 'package:beautygm/core/databases/api/api_consumer.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/clinics/data/models/clinic_model.dart';
import 'package:beautygm/features/reviews/data/models/reviews_model.dart';
import 'package:beautygm/features/reviews/domain/entities/reviews_entity.dart';
import 'package:dio/dio.dart';

class ReviewsRemoteDataSource {
  final ApiConsumer api;

  ReviewsRemoteDataSource({required this.api});

  Future<void> writeReview(WriteReviewParams params) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);
    await api.post(
      EndPoints.writeReview,
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
      data: {
        "cid": params.clinicID,
        "rating": params.rating,
        "text": params.reviewText,
      },
    );
  }

  Future<List<ReviewsModel>> getAllReviews() async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    final response = await api.get(
      EndPoints.getAllReviews,
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
    );

    final List data = response as List;

    final reviews = data.map((json) => ReviewsModel.fromJson(json)).toList();

    return reviews;
  }

  Future<List<ReviewsModel>> getReviewsByClinicID({
    required GetReviewsByClinicIDParams params,
  }) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    final response = await api.get(
      "${EndPoints.getReviewsByClinicID}${params.clinicID}",
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
    );

    final List data = response as List;

    return data.map((json) => ReviewsModel.fromJson(json)).toList();
  }

  Future<void> adminApproveRejectReview({
    required AdminApproveRejectReviewParams params,
  }) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);
    final String reviewID = params.reviewID;

    await api.patch(
      "${EndPoints.adminApproveRejectReview}$reviewID/",
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
      data: {"status": params.actionStatus},
    );
  }

  Future<List<ReviewsEntity>> adminGetAllReviews() async {
    final response = await api.get(EndPoints.getAllReviews);
    final List data = response.data;
    return data.map((json) => ReviewsModel.fromJson(json)).toList();
  }

  Future<ClinicModel> getClinicByID({
    required GetClinicByIDParams params,
  }) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);
    final String clinicID = params.clinicID;

    final response = await api.get(
      "${EndPoints.getClinics}/$clinicID",
      options: Options(headers: {"Authorization": "Bearer $accessKey"}),
    );

    return ClinicModel.fromJson(response);
  }
}
