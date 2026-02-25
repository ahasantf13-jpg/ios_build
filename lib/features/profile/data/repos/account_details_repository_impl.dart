import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/profile/data/sources/account_details_local_data_source.dart';
import 'package:beautygm/features/profile/data/sources/account_details_remote_data_source.dart';
import 'package:beautygm/features/profile/domain/entities/account_details_entity.dart';
import 'package:beautygm/features/profile/domain/repos/account_details_repository.dart';
import 'package:dartz/dartz.dart';

class AccountDetailsRepositoryImpl extends AccountDetailsRepository {
  final NetworkInfo networkInfo;
  final AccountDetailsRemoteDataSource remoteDataSource;
  final AccountDetailsLocalDataSource localDataSource;

  AccountDetailsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, AccountDetailsEntity>> getAccountDetials() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAccountDetails = await remoteDataSource.getAccountDetails();

        localDataSource.cacheAccountDetails(remoteAccountDetails);

        return Right(remoteAccountDetails);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      try {
        final localAccountDetails =
            await localDataSource.getLastAccountDetails();
        return Right(localAccountDetails as AccountDetailsEntity);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(
      {required UpdateProfileParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUpdate = await remoteDataSource.updateProfile(params);

        return Right(remoteUpdate);
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
