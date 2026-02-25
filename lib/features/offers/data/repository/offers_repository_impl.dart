import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/offers/data/source/offers_local_data_source.dart';
import 'package:beautygm/features/offers/data/source/offers_remote_data_source.dart';
import 'package:beautygm/features/offers/domain/entities/get_all_offers_entities.dart';
import 'package:beautygm/features/offers/domain/repository/offer_repository.dart';
import 'package:dartz/dartz.dart';

class OffersRepositoryImpl extends OfferRepository {
  final NetworkInfo networkInfo;
  final OffersRemoteDataSource remoteDataSource;
  final OffersLocalDataSource localDataSource;

  OffersRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> createNewOffer({
    required CreateOffersParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOffer = await remoteDataSource.createNewOffer(params);

        return Right(remoteOffer);
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
  Future<Either<Failure, List<GetAllOffersEntities>>> getAllOffers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOffers = await remoteDataSource.getAllOffers();

        localDataSource.cacheOffers(remoteOffers);

        return Right(remoteOffers);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      try {
        final localOffers = await localDataSource.getLastOffers();

        return Right(localOffers);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, void>> adminApproveRejectOffers({
    required AdminApproveRejectOffersParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final approvAndReject = await remoteDataSource.adminApproveRejectOffer(
          params,
        );

        return Right(approvAndReject);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection!"));
    }
  }
}
