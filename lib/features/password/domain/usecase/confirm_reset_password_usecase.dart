import 'package:dartz/dartz.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/password/domain/entities/confirm_reset_password_entity.dart';
import 'package:beautygm/features/password/domain/repository/password_repository.dart';

class ConfirmResetPasswordUsecase {
  final PasswordRepository repository;

  ConfirmResetPasswordUsecase({required this.repository});

  Future<Either<Failure, ConfirmResetPasswordEntity>> call(
      {required ConfirmResetPasswordParams params}) {
    return repository.confirmResetPassword(params: params);
  }
}
