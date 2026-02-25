import 'package:dartz/dartz.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/password/domain/repository/password_repository.dart';

class SetNewPasswordUsecase {
  final PasswordRepository repository;

  SetNewPasswordUsecase({required this.repository});

  Future<Either<Failure, void>> call({required NewPasswordParams params}) {
    return repository.setNewPassword(params: params);
  }
}
