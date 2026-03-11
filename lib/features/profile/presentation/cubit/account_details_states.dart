import 'package:beautygm/features/profile/domain/entities/account_details_entity.dart';

class AccountDetailsStates {}

class AccountDetailsInitial extends AccountDetailsStates {}

class GetAccountDetailsSuccessfully extends AccountDetailsStates {
  AccountDetailsEntity accountDetails;

  GetAccountDetailsSuccessfully({required this.accountDetails});
}

class GetAccountDetailsLoading extends AccountDetailsStates {}

class GetAccountDetailsFailure extends AccountDetailsStates {
  final String errMessage;

  GetAccountDetailsFailure({required this.errMessage});
}

class UpdateProfileLoading extends AccountDetailsStates {}

class UpdateProfileSuccessfully extends AccountDetailsStates {}

class UpdateProfileFailed extends AccountDetailsStates {
  final String errMessage;

  UpdateProfileFailed({required this.errMessage});
}
