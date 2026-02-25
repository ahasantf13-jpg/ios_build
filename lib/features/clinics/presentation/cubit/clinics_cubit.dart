import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/databases/api/dio_consumer.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/clinics/data/repos/clinics_repository_impl.dart';
import 'package:beautygm/features/clinics/data/source/clinics_local_data_source.dart';
import 'package:beautygm/features/clinics/data/source/clinics_remote_data_source.dart';
import 'package:beautygm/features/clinics/domain/usecases/admin_approve_reject_clinic_usecase.dart';
import 'package:beautygm/features/clinics/domain/usecases/create_new_clinic_usecase.dart';
import 'package:beautygm/features/clinics/domain/usecases/get_all_clinics_usecase.dart';
import 'package:beautygm/features/clinics/presentation/cubit/clinics_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicsCubit extends Cubit<ClinicsState> {
  ClinicsCubit() : super(ClinicsInitial());

  Future<void> getAllClinics() async {
    emit(GetClinicsLoading());

    final failureOrGetClinics = await GetAllClinicsUsecase(
      repository: ClinicsRepositoryImpl(
          networkInfo: getIt<NetworkInfo>(),
          remoteDataSource: ClinicsRemoteDataSource(api: getIt<DioConsumer>()),
          localDataSource: ClinicsLocalDataSource(cache: getIt<CacheHelper>())),
    ).call();

    failureOrGetClinics.fold(
      (failure) {
        emit(GetClinicsFailed(errMessage: failure.errMessage));
      },
      (clinics) {
        emit(GetClinicsSuccessfully(clinics: clinics));
      },
    );
  }

  Future<void> createNewClinic(CreateNewClinicParams params) async {
    emit(CreateNewClinicLoading());

    final failureOrClinicCreated = await CreateNewClinicUsecase(
      repository: ClinicsRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: ClinicsRemoteDataSource(api: getIt<DioConsumer>()),
        localDataSource: ClinicsLocalDataSource(cache: getIt<CacheHelper>()),
      ),
    ).call(params: params);

    failureOrClinicCreated.fold(
      (failure) => emit(CreateNewClinicFailed(errMessage: failure.errMessage)),
      (createdClinic) => emit(CreateNewClinicSuccess()),
    );
  }

  Future<void> adminApproveRejectClinic(
    AdminApproveRejectClinicParams params,
  ) async {
    emit(AdminApproveRejectClinicLoading());

    final failureOrSuccess = await AdminApproveRejectClinicUsecase(
      repository: ClinicsRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: ClinicsRemoteDataSource(api: getIt<DioConsumer>()),
        localDataSource: ClinicsLocalDataSource(cache: getIt<CacheHelper>()),
      ),
    ).call(params: params);

    failureOrSuccess.fold(
      (failure) =>
          emit(AdminApproveRejectClinicFailed(errMessage: failure.errMessage)),
      (createdClinic) async {
        emit(AdminApproveRejectClinicSuccessfully());
        await getAllClinics();
      },
    );
  }
}
