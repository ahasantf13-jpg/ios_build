import 'package:dartz/dartz.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/locations/domain/repositories/locations_repository.dart';

class AddNewLocationUsecase {
  final LocationsRepository repository;

  AddNewLocationUsecase({required this.repository});

  Future<Either<Failure, void>> call({required AddLocationParams params}) {
    return repository.addNewLocation(params: params);
  }
}
