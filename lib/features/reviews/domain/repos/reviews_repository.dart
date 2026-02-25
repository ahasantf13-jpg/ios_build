import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/clinics/domain/entities/clinic_entity.dart';
import 'package:beautygm/features/reviews/data/models/reviews_model.dart';
import 'package:beautygm/features/reviews/domain/entities/reviews_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, List<ReviewsEntity>>> getAllReviews();

  Future<Either<Failure, void>> writeReiew({
    required WriteReviewParams params,
  });

  Future<Either<Failure, void>> adimnApproveRejecrReview(
      {required AdminApproveRejectReviewParams params});

  Future<Either<Failure, List<ReviewsEntity>>> adminGetReviews();

  Future<Either<Failure, List<ReviewsModel>>> getReviewsByClinicID({
    required GetReviewsByClinicIDParams params,
  });

  Future<Either<Failure, ClinicEntity>> getClinicByID({
    required GetClinicByIDParams params,
  });
}
