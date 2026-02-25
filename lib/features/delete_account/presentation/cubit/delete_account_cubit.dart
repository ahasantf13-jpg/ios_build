import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/databases/api/dio_consumer.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/delete_account/data/repos/delete_account_repository_impl.dart';
import 'package:beautygm/features/delete_account/data/source/delete_account_remote_data_source.dart';
import 'package:beautygm/features/delete_account/domain/usecases/delete_account_usecase.dart';
import 'package:beautygm/features/delete_account/presentation/cubit/delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());

  Future<void> deleteAccount(DeleteAccountParams params) async {
    emit(DeleteAccountLoading());

    final result = await DeleteAccountUsecase(
      repository: DeleteAccountRepositoryImpl(
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: DeleteAccountRemoteDataSource(
          api: getIt<DioConsumer>(),
        ),
      ),
    ).call(params: params);

    result.fold(
      (failure) => emit(DeleteAccountFailed(errMessage: failure.errMessage)),
      (_) => emit(DeleteAccountSuccess()),
    );
  }
}
