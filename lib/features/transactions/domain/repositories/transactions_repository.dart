import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';

abstract class TransactionsRepository {
  Future<List<TransactionRequest>> fetchRequests({
    bool simulateError = false,
    bool simulateEmpty = false,
    bool simulateMalformedPayload = false,
  });

  Future<TransactionRequest> createRequest({
    required String title,
    required double amount,
    required String currency,
    required TransactionPriority priority,
    required String notes,
  });

  Future<TransactionRequest> updateRequestStatus({
    required String id,
    required TransactionStatus status,
  });
}