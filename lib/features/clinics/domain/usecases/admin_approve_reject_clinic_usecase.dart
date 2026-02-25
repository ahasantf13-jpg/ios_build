import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/clinics/domain/repos/clinic_repository.dart';
import 'package:dartz/dartz.dart';

class AdminApproveRejectClinicUsecase {
  final ClinicRepository repository;

  AdminApproveRejectClinicUsecase({required this.repository});

  Future<Either<Failure, void>> call({
    required AdminApproveRejectClinicParams params,
  }) {
    return repository.admingApproveRejectClinic(params: params);
  }
}
