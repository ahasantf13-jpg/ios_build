import 'package:dartz/dartz.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/profile/domain/repos/account_details_repository.dart';

class UpdateProfileUsecase {
  final AccountDetailsRepository repository;

  UpdateProfileUsecase({required this.repository});

  Future<Either<Failure, void>> call({required UpdateProfileParams params}) {
    return repository.updateProfile(params: params);
  }
}
