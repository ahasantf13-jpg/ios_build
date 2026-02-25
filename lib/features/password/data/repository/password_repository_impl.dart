import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/password/data/source/password_remote_data_source.dart';
import 'package:beautygm/features/password/domain/entities/confirm_reset_password_entity.dart';
import 'package:beautygm/features/password/domain/entities/reset_password_entity.dart';
import 'package:beautygm/features/password/domain/repository/password_repository.dart';
import 'package:dartz/dartz.dart';

class PasswordRepositoryImpl extends PasswordRepository {
  final NetworkInfo networkInfo;
  final PasswordRemoteDataSource remoteDataSource;

  PasswordRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ResetPasswordEntity>> resetPassword({
    required ResetPasswordParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.resetPassword(params);

        return Right(ResetPasswordEntity(detail: "Success"));
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
  Future<Either<Failure, ConfirmResetPasswordEntity>> confirmResetPassword(
      {required ConfirmResetPasswordParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.confirmResetPassword(params);

        return Right(ConfirmResetPasswordEntity(tempToken: response.tempToken));
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
  Future<Either<Failure, void>> setNewPassword(
      {required NewPasswordParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.setNewPassword(params);
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
  Future<Either<Failure, void>> resetPasswordByPassword(
      {required ResetPasswordByPasswordParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.resetPasswordByPassword(params);

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
