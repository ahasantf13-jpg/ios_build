import 'package:beautygm/core/errors/models/error_model.dart';

abstract class AppException implements Exception {
  final ErrorModel error;

  const AppException(this.error);

  @override
  String toString() => error.errorMessage;
}
