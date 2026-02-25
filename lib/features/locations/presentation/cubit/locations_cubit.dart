import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/databases/api/dio_consumer.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/locations/data/repository/locations_repository_impl.dart';
import 'package:beautygm/features/locations/data/source/locations_local_data_source.dart';
import 'package:beautygm/features/locations/data/source/locations_remote_data_source.dart';
import 'package:beautygm/features/locations/domain/usecases/add_new_location_usecase.dart';
import 'package:beautygm/features/locations/domain/usecases/delete_location_usecase.dart';
import 'package:beautygm/features/locations/domain/usecases/get_all_locations_usecase.dart';
import 'package:beautygm/features/locations/presentation/cubit/locations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsCubit extends Cubit<LocationsStates> {
  LocationsCubit() : super(LocationsInitial());

  Future<void> getAllLocations() async {
    emit(GetAllLocationsLoading());

    final failureOrLocations = await GetAllLocationsUsecase(
      repository: LocationsRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: LocationsRemoteDataSource(
          api: getIt<DioConsumer>(),
        ),
        localDataSource: LocationsLocalDataSource(cache: getIt<CacheHelper>()),
      ),
    ).call();

    failureOrLocations.fold(
      (failure) => emit(GetAllLocationsFailed(errMessage: failure.errMessage)),
      (locations) {
        emit(GetAllLocationsSuccessfully(location: locations));

        final defaultList = locations.where((loc) => loc.isDefault == true);

        if (defaultList.isNotEmpty) {
          final defaultLocation = defaultList.first;

          getIt<CacheHelper>().save(
            ApiKey.mainLocation,
            defaultLocation.address,
          );
        }
      },
    );
  }

  Future<void> addNewLocation(AddLocationParams params) async {
    emit(AddNewLocationLoading());

    final failureOrAdded = await AddNewLocationUsecase(
            repository: LocationsRepositoryImpl(
                networkInfo: getIt<NetworkInfo>(),
                remoteDataSource:
                    LocationsRemoteDataSource(api: getIt<DioConsumer>()),
                localDataSource:
                    LocationsLocalDataSource(cache: getIt<CacheHelper>())))
        .call(params: params);

    failureOrAdded.fold(
        (failure) => emit(AddNewLocationFailed(errMessage: failure.errMessage)),
        (success) => emit(AddNewLocationSuccessfully()));
  }

  Future<void> deleteLocation(DeleteLocationParams params) async {
    emit(DeleteLocationLoading());

    final failureOrDeleted = await DeleteLocationUsecase(
            repository: LocationsRepositoryImpl(
                networkInfo: getIt<NetworkInfo>(),
                remoteDataSource:
                    LocationsRemoteDataSource(api: getIt<DioConsumer>()),
                localDataSource:
                    LocationsLocalDataSource(cache: getIt<CacheHelper>())))
        .call(params: params);

    failureOrDeleted.fold(
        (failure) => emit(DeleteLocationFailed(errMessage: failure.errMessage)),
        (success) => emit(DeleteLocationSuccessfully()));
  }
}
