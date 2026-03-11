import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/features/auth/domain/entities/login_entity.dart';
import 'package:beautygm/features/auth/domain/repos/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginGuestUsecase {
  final AuthReposirory authReposirory;

  LoginGuestUsecase({required this.authReposirory});

  Future<Either<Failure, LoginEntity>> call() {
    return authReposirory.loginGuest();
  }
}
