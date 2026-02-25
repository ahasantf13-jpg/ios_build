import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/features/offers/domain/entities/get_all_offers_entities.dart';
import 'package:beautygm/features/offers/domain/repository/offer_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllOffersUsecase {
  final OfferRepository repository;

  GetAllOffersUsecase({required this.repository});

  Future<Either<Failure, List<GetAllOffersEntities>>> call() {
    return repository.getAllOffers();
  }
}
