import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/databases/api/dio_consumer.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/password/data/repository/password_repository_impl.dart';
import 'package:beautygm/features/password/data/source/password_remote_data_source.dart';
import 'package:beautygm/features/password/domain/usecase/confirm_reset_password_usecase.dart';
import 'package:beautygm/features/password/domain/usecase/reset_password_by_password_usecase.dart';
import 'package:beautygm/features/password/domain/usecase/reset_password_usecase.dart';
import 'package:beautygm/features/password/domain/usecase/set_new_password_usecase.dart';
import 'package:beautygm/features/password/presentation/cubit/password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordCubit extends Cubit<PasswordStates> {
  PasswordCubit() : super(PasswordInitial());

  Future<void> resetPassword(ResetPasswordParams params) async {
    emit(ResetPasswordLoading());

    final failureOrResetPassword = await ResetPasswordUsecase(
      repository: PasswordRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: PasswordRemoteDataSource(
          api: getIt<DioConsumer>(),
        ),
      ),
    ).call(params: params);

    failureOrResetPassword.fold(
      (failure) => emit(ResetPasswordFailed(errMessage: failure.errMessage)),
      (resetted) => emit(ResetPasswordSuccessfully()),
    );
  }

  Future<void> confirmResetPassword(ConfirmResetPasswordParams params) async {
    emit(ConfirmResetPasswordLoading());

    final failureOrConfirmed = await ConfirmResetPasswordUsecase(
            repository: PasswordRepositoryImpl(
                networkInfo: getIt<NetworkInfo>(),
                remoteDataSource:
                    PasswordRemoteDataSource(api: getIt<DioConsumer>())))
        .call(params: params);

    failureOrConfirmed.fold(
        (failure) =>
            emit(ConfirmResetPasswordFailed(errMessage: failure.errMessage)),
        (confirmed) => emit(
            ConfirmResetPasswordSuccessfully(tempToken: confirmed.tempToken)));
  }

  Future<void> setNewPassword(NewPasswordParams params) async {
    final failureOrSetNew = await SetNewPasswordUsecase(
            repository: PasswordRepositoryImpl(
                networkInfo: getIt<NetworkInfo>(),
                remoteDataSource:
                    PasswordRemoteDataSource(api: getIt<DioConsumer>())))
        .call(params: params);

    failureOrSetNew.fold(
        (failure) => emit(SetNewPasswordFailed(errMessage: failure.errMessage)),
        (success) => emit(SetNewPasswordSuccessfully()));
  }

  Future<void> setNewPasswordByPassword(
      ResetPasswordByPasswordParams params) async {
    emit(SetNewPasswordByPasswordLoading());

    final failureOrNewPass = await ResetPasswordByPasswordUsecase(
            repository: PasswordRepositoryImpl(
                networkInfo: getIt<NetworkInfo>(),
                remoteDataSource:
                    PasswordRemoteDataSource(api: getIt<DioConsumer>())))
        .call(params: params);

    failureOrNewPass.fold(
        (failure) => emit(
            SetNewPasswordByPasswordFailed(errMessage: failure.errMessage)),
        (success) => emit(SetNewPasswordByPasswordSuccessfully()));
  }
}
