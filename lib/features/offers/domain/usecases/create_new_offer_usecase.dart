import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/offers/domain/repository/offer_repository.dart';
import 'package:dartz/dartz.dart';

class CreateNewOfferUsecase {
  final OfferRepository repository;

  CreateNewOfferUsecase({required this.repository});

  Future<Either<Failure, void>> call({
    required CreateOffersParams params,
  }) {
    return repository.createNewOffer(params: params);
  }
}
