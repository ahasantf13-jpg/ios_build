import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/auth/data/source/auth_remote_data_source.dart';
import 'package:beautygm/features/auth/domain/entities/login_entity.dart';
import 'package:beautygm/features/auth/domain/repos/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthReposirory {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>> loginUser({
    required LoginParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final loggedInUserDetails = await remoteDataSource.loginUser(params);

        return Right(loggedInUserDetails);
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
  Future<Either<Failure, void>> signUpClinicOwner({
    required SignupUserParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final signedUpClinicOwner = await remoteDataSource.signupUser(params);

        return Right(signedUpClinicOwner);
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
  Future<Either<Failure, LoginEntity>> loginGuest() async {
    if (await networkInfo.isConnected) {
      try {
        final guestUser = await remoteDataSource.loginGuest();

        return Right(guestUser);
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
