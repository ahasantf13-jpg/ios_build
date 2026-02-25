import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/databases/api/dio_consumer.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/reviews/data/repos/reviews_repository_impl.dart';
import 'package:beautygm/features/reviews/data/source/reviews_local_data_source.dart';
import 'package:beautygm/features/reviews/data/source/reviews_remote_data_source.dart';
import 'package:beautygm/features/reviews/domain/usecase/admin_approve_reject_review_usecase.dart';
import 'package:beautygm/features/reviews/domain/usecase/get_all_reviews_usecase.dart';
import 'package:beautygm/features/reviews/domain/usecase/write_a_review_usecase.dart';
import 'package:beautygm/features/reviews/presentation/cubit/reviews_states.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewsStates> {
  ReviewsCubit() : super(ReviewsInitial());

  Future<void> getAllReviews() async {
    emit(GetAllReviewsLoading());

    final failureOrGetReviews = await GetAllReviewsUsecase(
      repository: ReviewsRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: ReviewsRemoteDataSource(api: getIt<DioConsumer>()),
        localDataSource: ReviewsLocalDataSource(cache: getIt<CacheHelper>()),
      ),
    ).call();

    failureOrGetReviews.fold(
      (failure) => emit(GetAllReviewsFailed(errMessage: failure.errMessage)),
      (reviews) => emit(GetAllReviewsSuccessfully(reviews: reviews)),
    );
  }

  Future<void> writeNewReview(WriteReviewParams params) async {
    emit(WriteReviewLoading());

    final failureOrWriteReview = await WriteAReviewUsecase(
      repository: ReviewsRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: ReviewsRemoteDataSource(api: getIt<DioConsumer>()),
        localDataSource: ReviewsLocalDataSource(cache: getIt<CacheHelper>()),
      ),
    ).call(params: params);

    failureOrWriteReview.fold(
      (failure) => emit(WriteReviewFailed(errMessage: failure.errMessage)),
      (review) => emit(WriteReviewSuccessfully()),
    );
  }

  Future<void> admingApproveRejectReview({
    required AdminApproveRejectReviewParams params,
  }) async {
    emit(AdmingApproveRejectReviewLoading());

    final response = await AdminApproveRejectReviewUsecase(
      repository: ReviewsRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: ReviewsRemoteDataSource(api: getIt<DioConsumer>()),
        localDataSource: ReviewsLocalDataSource(cache: getIt<CacheHelper>()),
      ),
    ).call(params: params);

    response.fold(
      (failure) =>
          emit(AdmingApproveRejectReviewFailed(errMessage: failure.errMessage)),
      (approved) {
        emit(AdmingApproveRejectReviewSuccess());

        getAllReviews();
      },
    );
  }
}
