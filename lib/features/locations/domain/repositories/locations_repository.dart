import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/locations/domain/entities/location_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LocationsRepository {
  Future<Either<Failure, List<LocationEntity>>> getAllLocations();

  Future<Either<Failure, void>> addNewLocation(
      {required AddLocationParams params});

  Future<Either<Failure, void>> deleteLocation(
      {required DeleteLocationParams params});
}
