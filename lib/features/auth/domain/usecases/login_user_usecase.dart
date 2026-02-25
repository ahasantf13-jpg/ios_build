import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/auth/domain/entities/login_entity.dart';
import 'package:beautygm/features/auth/domain/repos/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUserUsecase {
  final AuthReposirory repository;

  LoginUserUsecase({required this.repository});

  Future<Either<Failure, LoginEntity>> call({required LoginParams params}) {
    return repository.loginUser(params: params);
  }
}
