import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/clinics/data/source/clinics_local_data_source.dart';
import 'package:beautygm/features/clinics/data/source/clinics_remote_data_source.dart';
import 'package:beautygm/features/clinics/domain/entities/clinic_entity.dart';
import 'package:beautygm/features/clinics/domain/repos/clinic_repository.dart';
import 'package:dartz/dartz.dart';

class ClinicsRepositoryImpl extends ClinicRepository {
  final NetworkInfo networkInfo;
  final ClinicsRemoteDataSource remoteDataSource;
  final ClinicsLocalDataSource localDataSource;

  ClinicsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ClinicEntity>>> getAllClinics() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinics = await remoteDataSource.getClinics();

        await localDataSource.cacheClinics(remoteClinics);

        return Right(remoteClinics);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      try {
        final localClinis = await localDataSource.getLastClinics();

        return Right(localClinis);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, void>> createNewClinic({
    required CreateNewClinicParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createNewClinic(params);

        return const Right(null);
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
  Future<Either<Failure, void>> admingApproveRejectClinic({
    required AdminApproveRejectClinicParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.adminApproveRejectClinic(
          params: params,
        );

        return const Right(null);
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
