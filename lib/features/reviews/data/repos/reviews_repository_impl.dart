import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/clinics/domain/entities/clinic_entity.dart';
import 'package:beautygm/features/reviews/data/models/reviews_model.dart';
import 'package:beautygm/features/reviews/data/source/reviews_local_data_source.dart';
import 'package:beautygm/features/reviews/data/source/reviews_remote_data_source.dart';
import 'package:beautygm/features/reviews/domain/entities/reviews_entity.dart';
import 'package:beautygm/features/reviews/domain/repos/reviews_repository.dart';
import 'package:dartz/dartz.dart';

class ReviewsRepositoryImpl extends ReviewsRepository {
  final NetworkInfo networkInfo;
  final ReviewsRemoteDataSource remoteDataSource;
  final ReviewsLocalDataSource localDataSource;

  ReviewsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> writeReiew({
    required WriteReviewParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final writeReview = await remoteDataSource.writeReview(params);
        return Right(writeReview);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, List<ReviewsEntity>>> getAllReviews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteReviews = await remoteDataSource.getAllReviews();

        localDataSource.cacheReviews(remoteReviews);

        return Right(remoteReviews);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      try {
        final localReviews = await localDataSource.getLastReviews();

        return Right(localReviews);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, void>> adimnApproveRejecrReview({
    required AdminApproveRejectReviewParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.adminApproveRejectReview(
          params: params,
        );
        return Right(response);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, List<ReviewsEntity>>> adminGetReviews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteReviews = await remoteDataSource.getAllReviews();

        final entityList = remoteReviews
            .map<ReviewsEntity>((review) => review as ReviewsEntity)
            .toList();

        return Right(entityList);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, ClinicEntity>> getClinicByID({
    required GetClinicByIDParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getClinicByID(params: params);

        return Right(response);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection!"));
    }
  }

  @override
  Future<Either<Failure, List<ReviewsModel>>> getReviewsByClinicID({
    required GetReviewsByClinicIDParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteReviews = await remoteDataSource.getReviewsByClinicID(
          params: params,
        );

        localDataSource.cacheReviews(remoteReviews);

        return Right(remoteReviews);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      try {
        final localReviews = await localDataSource.getLastReviews();
        return Right(localReviews);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      }
    }
  }
}
