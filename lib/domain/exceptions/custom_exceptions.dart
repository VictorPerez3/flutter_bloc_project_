import '../../presentation/utils/constants/app_strings.dart';

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = AppStrings.networkExceptionMessage]);
}

class ServerException implements Exception {
  final String message;

  ServerException([this.message = AppStrings.serverExceptionMessage]);
}
