import 'package:financial_requests_module/core/error/app_exception.dart';
import 'package:financial_requests_module/features/transactions/data/datasources/transactions_remote_or_mock_datasource.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/domain/repositories/transactions_repository.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  TransactionsRepositoryImpl({
    TransactionsRemoteOrMockDataSource? dataSource,
  }) : _dataSource = dataSource ?? TransactionsRemoteOrMockDataSource();

  final TransactionsRemoteOrMockDataSource _dataSource;

  @override
  Future<List<TransactionRequest>> fetchRequests({
    bool simulateError = false,
    bool simulateEmpty = false,
    bool simulateMalformedPayload = false,
  }) async {
    try {
      final dtos = await _dataSource.getTransactions(
        simulateError: simulateError,
        simulateEmpty: simulateEmpty,
        simulateMalformedPayload: simulateMalformedPayload,
      );
      return dtos.map((dto) => dto.toEntity()).toList(growable: false);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(
        type: AppErrorType.unknown,
        message: 'Failed to load requests: $e',
      );
    }
  }

  @override
  Future<TransactionRequest> createRequest({
    required String title,
    required double amount,
    required String currency,
    required TransactionPriority priority,
    required String notes,
  }) async {
    try {
      final dto = await _dataSource.createTransaction(
        title: title,
        amount: amount,
        currency: currency,
        priority: priority,
        notes: notes,
      );
      return dto.toEntity();
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(
        type: AppErrorType.unknown,
        message: 'Failed to create request: $e',
      );
    }
  }

  @override
  Future<TransactionRequest> updateRequestStatus({
    required String id,
    required TransactionStatus status,
  }) async {
    try {
      final dto = await _dataSource.updateStatus(id: id, status: status);
      return dto.toEntity();
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(
        type: AppErrorType.unknown,
        message: 'Failed to update status: $e',
      );
    }
  }
}