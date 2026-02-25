import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/features/profile/domain/entities/account_details_entity.dart';
import 'package:beautygm/features/profile/domain/repos/account_details_repository.dart';
import 'package:dartz/dartz.dart';

class GetAccountDetailsUsecase {
  final AccountDetailsRepository repository;

  GetAccountDetailsUsecase({required this.repository});
  Future<Either<Failure, AccountDetailsEntity>> call() {
    return repository.getAccountDetials();
  }
}
