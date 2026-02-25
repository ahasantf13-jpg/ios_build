import 'package:beautygm/core/databases/api/api_consumer.dart';
import 'package:beautygm/core/databases/api/end_points.dart';
import 'package:beautygm/core/databases/cache/cache_helper.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/features/profile/data/models/account_details_model.dart';
import 'package:dio/dio.dart';

class AccountDetailsRemoteDataSource {
  final ApiConsumer api;
  AccountDetailsRemoteDataSource({required this.api});

  Future<AccountDetailsModel> getAccountDetails() async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    final response = await api.get(
      EndPoints.accountDetails,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessKey',
          'Accept': 'application/json',
        },
      ),
    );
    return AccountDetailsModel.fromJson(response);
  }

  Future<void> updateProfile(UpdateProfileParams params) async {
    final String accessKey = getIt<CacheHelper>().get(ApiKey.access);

    FormData formData = FormData();

    if (params.fullName != null) {
      formData.fields.add(MapEntry("fullname", params.fullName!));
    }
    if (params.phoneNumber != null) {
      formData.fields.add(MapEntry("phone_number", params.phoneNumber!));
    }
    if (params.birthday != null) {
      formData.fields.add(MapEntry("date_of_birth", params.birthday!));
    }
    if (params.isMale != null) {
      formData.fields
          .add(MapEntry("is_male", params.isMale! ? "true" : "false"));
    }

    // رفع الصورة
    if (params.profileImage != null) {
      formData.files.add(MapEntry(
        "profile_image",
        await MultipartFile.fromFile(params.profileImage!.path),
      ));
    }

    await api.patch(
      EndPoints.accountDetails,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessKey',
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
        },
      ),
    );
  }
}
