import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/databases/api/dio_consumer.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/reviews/data/repos/reviews_repository_impl.dart';
import 'package:beautygm/features/reviews/data/source/reviews_local_data_source.dart';
import 'package:beautygm/features/reviews/data/source/reviews_remote_data_source.dart';
import 'package:beautygm/features/reviews/domain/usecase/get_reviews_by_clinic_i_d_usecase.dart';
import 'package:beautygm/features/reviews/presentation/cubit/reviews_clinic_i_d_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsClinicIDCubit extends Cubit<ReviewsClinicIDStates> {
  ReviewsClinicIDCubit() : super(ReviewsClinicIDInitial());

  Future<void> getAllReviewsByClinicID(
    GetReviewsByClinicIDParams params,
  ) async {
    emit(GetAllReviewsByClinicIDLoading());

    final failureOrGetReviews = await GetReviewsByClinicIDUsecase(
      repository: ReviewsRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: ReviewsRemoteDataSource(api: getIt<DioConsumer>()),
        localDataSource: ReviewsLocalDataSource(cache: getIt<CacheHelper>()),
      ),
    ).call(params: params);

    failureOrGetReviews.fold(
      (failure) =>
          emit(GetAllReviewsByClinicIDFailed(errMessage: failure.errMessage)),
      (reviews) => emit(GetAllReviewsByClinicIDSuccessfully(reviews: reviews)),
    );
  }
}
