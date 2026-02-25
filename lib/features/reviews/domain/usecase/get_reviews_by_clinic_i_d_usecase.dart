import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/reviews/domain/entities/reviews_entity.dart';
import 'package:beautygm/features/reviews/domain/repos/reviews_repository.dart';
import 'package:dartz/dartz.dart';

class GetReviewsByClinicIDUsecase {
  final ReviewsRepository repository;

  GetReviewsByClinicIDUsecase({required this.repository});

  Future<Either<Failure, List<ReviewsEntity>>> call({
    required GetReviewsByClinicIDParams params,
  }) {
    return repository.getReviewsByClinicID(params: params);
  }
}
