import 'package:dartz/dartz.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';

abstract class DeleteAccountRepository {
  Future<Either<Failure, void>> deleteAccount(
      {required DeleteAccountParams params});
}
