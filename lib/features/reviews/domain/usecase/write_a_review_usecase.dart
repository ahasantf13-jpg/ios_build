import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/reviews/domain/repos/reviews_repository.dart';
import 'package:dartz/dartz.dart';

class WriteAReviewUsecase {
  final ReviewsRepository repository;

  WriteAReviewUsecase({required this.repository});

  Future<Either<Failure, void>> call({
    required WriteReviewParams params,
  }) {
    return repository.writeReiew(params: params);
  }
}
