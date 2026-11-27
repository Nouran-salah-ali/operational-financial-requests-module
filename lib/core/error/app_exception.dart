enum AppErrorType {
  network,
  timeout,
  malformedData,
  validation,
  unknown,
}

class AppException implements Exception {
  const AppException({
    required this.type,
    required this.message,
    this.code,
  });

  final AppErrorType type;
  final String message;
  final String? code;

  @override
  String toString() => 'AppException(type: $type, code: $code, message: $message)';
}