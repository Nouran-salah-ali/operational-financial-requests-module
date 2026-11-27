import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/domain/repositories/transactions_repository.dart';

class GetTransactionsUseCase {
  const GetTransactionsUseCase(this._repository);

  final TransactionsRepository _repository;

  Future<List<TransactionRequest>> call({
    bool simulateError = false,
    bool simulateEmpty = false,
    bool simulateMalformedPayload = false,
  }) {
    return _repository.fetchRequests(
      simulateError: simulateError,
      simulateEmpty: simulateEmpty,
      simulateMalformedPayload: simulateMalformedPayload,
    );
  }
}