import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/password/domain/entities/reset_password_entity.dart';
import 'package:beautygm/features/password/domain/repository/password_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUsecase {
  final PasswordRepository repository;

  ResetPasswordUsecase({required this.repository});

  Future<Either<Failure, ResetPasswordEntity>> call({
    required ResetPasswordParams params,
  }) {
    return repository.resetPassword(params: params);
  }
}
