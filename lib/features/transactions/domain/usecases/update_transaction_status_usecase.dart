import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/domain/repositories/transactions_repository.dart';

class UpdateTransactionStatusUseCase {
  const UpdateTransactionStatusUseCase(this._repository);

  final TransactionsRepository _repository;

  Future<TransactionRequest> call({
    required String id,
    required TransactionStatus status,
  }) {
    return _repository.updateRequestStatus(
      id: id,
      status: status,
    );
  }
}