import 'package:financial_requests_module/core/error/app_exception.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/create_transaction_usecase.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/update_transaction_status_usecase.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit({
    required GetTransactionsUseCase getTransactions,
    required CreateTransactionUseCase createTransaction,
    required UpdateTransactionStatusUseCase updateTransactionStatus,
  })  : _getTransactions = getTransactions,
        _createTransaction = createTransaction,
        _updateTransactionStatus = updateTransactionStatus,
        super(const TransactionsState());

  final GetTransactionsUseCase _getTransactions;
  final CreateTransactionUseCase _createTransaction;
  final UpdateTransactionStatusUseCase _updateTransactionStatus;

  Future<void> loadTransactions({
    bool simulateError = false,
    bool simulateEmpty = false,
    bool simulateMalformedPayload = false,
  }) async {
    emit(
      state.copyWith(
        status: TransactionsUiStatus.loading,
        clearError: true,
      ),
    );

    try {
      final List<TransactionRequest> items = await _getTransactions(
        simulateError: simulateError,
        simulateEmpty: simulateEmpty,
        simulateMalformedPayload: simulateMalformedPayload,
      );

      _emitFilteredState(
        allItems: items,
        filterStatus: state.filterStatus,
        clearFilterStatus: state.filterStatus == null,
        searchQuery: state.searchQuery,
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: TransactionsUiStatus.error,
          errorMessage: e.message,
          errorCode: e.code,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: TransactionsUiStatus.error,
          errorMessage: 'Unexpected error while loading transactions.',
        ),
      );
    }
  }

  void filterByStatus(TransactionStatus? status) {
    _emitFilteredState(
      allItems: state.allItems,
      filterStatus: status,
      clearFilterStatus: status == null,
      searchQuery: state.searchQuery,
    );
  }

  void updateSearchQuery(String query) {
    _emitFilteredState(
      allItems: state.allItems,
      filterStatus: state.filterStatus,
      clearFilterStatus: state.filterStatus == null,
      searchQuery: query,
    );
  }

  Future<bool> createTransaction({
    required String title,
    required double amount,
    required String currency,
    required TransactionPriority priority,
    required String notes,
  }) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      final TransactionRequest created = await _createTransaction(
        title: title,
        amount: amount,
        currency: currency,
        priority: priority,
        notes: notes,
      );

      final List<TransactionRequest> updatedAll = <TransactionRequest>[
        created,
        ...state.allItems,
      ];

      _emitFilteredState(
        allItems: updatedAll,
        filterStatus: state.filterStatus,
        clearFilterStatus: state.filterStatus == null,
        searchQuery: state.searchQuery,
        isSubmitting: false,
      );
      return true;
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: TransactionsUiStatus.error,
          isSubmitting: false,
          errorMessage: e.message,
          errorCode: e.code,
        ),
      );
      return false;
    } catch (_) {
      emit(
        state.copyWith(
          status: TransactionsUiStatus.error,
          isSubmitting: false,
          errorMessage: 'Failed to create transaction request.',
        ),
      );
      return false;
    }
  }

  Future<bool> updateStatus({
    required String id,
    required TransactionStatus status,
  }) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      final TransactionRequest updated = await _updateTransactionStatus(
        id: id,
        status: status,
      );

      final List<TransactionRequest> updatedAll = state.allItems
          .map((item) => item.id == id ? updated : item)
          .toList();

      _emitFilteredState(
        allItems: updatedAll,
        filterStatus: state.filterStatus,
        clearFilterStatus: state.filterStatus == null,
        searchQuery: state.searchQuery,
        isSubmitting: false,
      );
      return true;
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: TransactionsUiStatus.error,
          isSubmitting: false,
          errorMessage: e.message,
          errorCode: e.code,
        ),
      );
      return false;
    } catch (_) {
      emit(
        state.copyWith(
          status: TransactionsUiStatus.error,
          isSubmitting: false,
          errorMessage: 'Failed to update transaction status.',
        ),
      );
      return false;
    }
  }

  void _emitFilteredState({
    required List<TransactionRequest> allItems,
    required TransactionStatus? filterStatus,
    bool clearFilterStatus = false,
    required String searchQuery,
    bool isSubmitting = false,
  }) {
    final String normalizedQuery = searchQuery.trim().toLowerCase();

    final List<TransactionRequest> filtered = allItems.where((item) {
      final bool matchesStatus =
          filterStatus == null || item.status == filterStatus;

      final bool matchesQuery = normalizedQuery.isEmpty ||
          item.title.toLowerCase().contains(normalizedQuery) ||
          item.referenceId.toLowerCase().contains(normalizedQuery);

      return matchesStatus && matchesQuery;
    }).toList();

    final TransactionsUiStatus nextStatus = filtered.isEmpty
        ? TransactionsUiStatus.empty
        : TransactionsUiStatus.success;

    emit(
      state.copyWith(
        status: nextStatus,
        allItems: allItems,
        visibleItems: filtered,
        filterStatus: filterStatus,
        clearFilterStatus: clearFilterStatus,
        searchQuery: searchQuery,
        isSubmitting: isSubmitting,
        clearError: true,
      ),
    );
  }
}