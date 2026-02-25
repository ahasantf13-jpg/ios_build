import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/profile/domain/entities/account_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AccountDetailsRepository {
  Future<Either<Failure, AccountDetailsEntity>> getAccountDetials();

  Future<Either<Failure, void>> updateProfile(
      {required UpdateProfileParams params});
}
