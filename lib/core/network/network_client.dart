import 'dart:async';

import 'package:financial_requests_module/core/error/app_exception.dart';

class NetworkClient {
  const NetworkClient({
    this.defaultDelay = const Duration(milliseconds: 550),
    this.requestTimeout = const Duration(seconds: 6),
  });

  final Duration defaultDelay;
  final Duration requestTimeout;

  Future<T> execute<T>(
      Future<T> Function() action, {
        Duration? delay,
      }) async {
    try {
      final effectiveDelay = delay ?? defaultDelay;
      if (effectiveDelay > Duration.zero) {
        await Future<void>.delayed(effectiveDelay);
      }
      return await action().timeout(
        requestTimeout,
        onTimeout: () {
          throw const AppException(
            type: AppErrorType.timeout,
            message: 'Request timed out while communicating with the server.',
            code: 'TIMEOUT',
          );
        },
      );
    } on AppException {
      rethrow;
    } on TimeoutException {
      throw const AppException(
        type: AppErrorType.timeout,
        message: 'Network operation timed out.',
        code: 'TIMEOUT',
      );
    } catch (e) {
      throw AppException(
        type: AppErrorType.network,
        message: 'Unexpected network failure: $e',
        code: 'NETWORK_ERROR',
      );
    }
  }
}