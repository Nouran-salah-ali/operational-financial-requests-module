import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/domain/repositories/transactions_repository.dart';

class CreateTransactionUseCase {
  const CreateTransactionUseCase(this._repository);

  final TransactionsRepository _repository;

  Future<TransactionRequest> call({
    required String title,
    required double amount,
    required String currency,
    required TransactionPriority priority,
    required String notes,
  }) {
    return _repository.createRequest(
      title: title,
      amount: amount,
      currency: currency,
      priority: priority,
      notes: notes,
    );
  }
}