import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/features/clinics/domain/entities/clinic_entity.dart';
import 'package:beautygm/features/clinics/domain/repos/clinic_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllClinicsUsecase {
  final ClinicRepository repository;

  GetAllClinicsUsecase({required this.repository});

  Future<Either<Failure, List<ClinicEntity>>> call() {
    return repository.getAllClinics();
  }
}
