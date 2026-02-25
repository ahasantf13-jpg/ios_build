import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/offers/domain/repository/offer_repository.dart';
import 'package:dartz/dartz.dart';

class AdminApproveRejectOffersUsecase {
  final OfferRepository repository;

  AdminApproveRejectOffersUsecase({required this.repository});

  Future<Either<Failure, void>> call({
    required AdminApproveRejectOffersParams params,
  }) {
    return repository.adminApproveRejectOffers(params: params);
  }
}
