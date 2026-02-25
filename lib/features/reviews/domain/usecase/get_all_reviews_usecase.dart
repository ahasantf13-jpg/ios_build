import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/features/reviews/domain/entities/reviews_entity.dart';
import 'package:beautygm/features/reviews/domain/repos/reviews_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllReviewsUsecase {
  final ReviewsRepository repository;

  GetAllReviewsUsecase({required this.repository});

  Future<Either<Failure, List<ReviewsEntity>>> call() {
    return repository.getAllReviews();
  }
}
