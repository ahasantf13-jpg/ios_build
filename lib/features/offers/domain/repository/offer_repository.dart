import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/offers/domain/entities/get_all_offers_entities.dart';
import 'package:dartz/dartz.dart';

abstract class OfferRepository {
  Future<Either<Failure, void>> createNewOffer({
    required CreateOffersParams params,
  });

  Future<Either<Failure, List<GetAllOffersEntities>>> getAllOffers();

  Future<Either<Failure, void>> adminApproveRejectOffers(
      {required AdminApproveRejectOffersParams params});
}
