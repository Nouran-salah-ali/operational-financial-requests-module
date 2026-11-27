import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';

enum TransactionsUiStatus {
  loading,
  success,
  empty,
  error,
}

class TransactionsState {
  const TransactionsState({
    this.status = TransactionsUiStatus.loading,
    this.allItems = const <TransactionRequest>[],
    this.visibleItems = const <TransactionRequest>[],
    this.filterStatus,
    this.searchQuery = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.errorCode,
  });

  final TransactionsUiStatus status;
  final List<TransactionRequest> allItems;
  final List<TransactionRequest> visibleItems;
  final TransactionStatus? filterStatus;
  final String searchQuery;
  final bool isSubmitting;
  final String? errorMessage;
  final String? errorCode;

  bool get isLoading => status == TransactionsUiStatus.loading;
  bool get isSuccess => status == TransactionsUiStatus.success;
  bool get isEmpty => status == TransactionsUiStatus.empty;
  bool get isError => status == TransactionsUiStatus.error;

  TransactionsState copyWith({
    TransactionsUiStatus? status,
    List<TransactionRequest>? allItems,
    List<TransactionRequest>? visibleItems,
    TransactionStatus? filterStatus,
    bool clearFilterStatus = false,
    String? searchQuery,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
    String? errorCode,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      allItems: allItems ?? this.allItems,
      visibleItems: visibleItems ?? this.visibleItems,
      filterStatus:
      clearFilterStatus ? null : (filterStatus ?? this.filterStatus),
      searchQuery: searchQuery ?? this.searchQuery,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
    );
  }
}