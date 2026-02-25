import 'package:dartz/dartz.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/delete_account/domain/repos/delete_account_repository.dart';

class DeleteAccountUsecase {
  final DeleteAccountRepository repository;

  DeleteAccountUsecase({required this.repository});

  Future<Either<Failure, void>> call({required DeleteAccountParams params}) {
    return repository.deleteAccount(params: params);
  }
}
