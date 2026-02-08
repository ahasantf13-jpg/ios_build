import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection _checker;

  NetworkInfoImpl({InternetConnection? checker})
      : _checker = checker ?? InternetConnection();

  @override
  Future<bool> get isConnected async {
    try {
      return await _checker.hasInternetAccess;
    } catch (_) {
      return false;
    }
  }
}
