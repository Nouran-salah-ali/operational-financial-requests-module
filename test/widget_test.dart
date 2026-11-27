import 'package:financial_requests_module/app.dart';
import 'package:financial_requests_module/core/localization/domain/repositories/locale_repository.dart';
import 'package:financial_requests_module/core/localization/domain/usecases/get_saved_locale_usecase.dart';
import 'package:financial_requests_module/core/localization/domain/usecases/save_locale_usecase.dart';
import 'package:financial_requests_module/core/localization/presentation/cubit/locale_cubit.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/create_transaction_usecase.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/update_transaction_status_usecase.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' hide TextDirection;

class _InMemoryLocaleRepository implements LocaleRepository {
  Locale _saved = const Locale('en');

  @override
  Future<Locale> getSavedLocale() async => _saved;

  @override
  Future<void> saveLocale(Locale locale) async {
    _saved = locale;
  }
}

class _InMemoryTransactionsRepository implements TransactionsRepository {
  final List<TransactionRequest> _items = <TransactionRequest>[];

  @override
  Future<List<TransactionRequest>> fetchRequests({
    bool simulateError = false,
    bool simulateEmpty = false,
    bool simulateMalformedPayload = false,
  }) async {
    return List<TransactionRequest>.unmodifiable(_items);
  }

  @override
  Future<TransactionRequest> createRequest({
    required String title,
    required double amount,
    required String currency,
    required TransactionPriority priority,
    required String notes,
  }) async {
    final TransactionRequest created = TransactionRequest(
      id: 'tx-${_items.length + 1}',
      referenceId: 'REF-00${_items.length + 1}',
      title: title,
      amount: amount,
      currency: currency,
      priority: priority,
      status: TransactionStatus.pending,
      notes: notes,
      createdAt: DateTime(2026, 11, 27),
    );
    _items.insert(0, created);
    return created;
  }

  @override
  Future<TransactionRequest> updateRequestStatus({
    required String id,
    required TransactionStatus status,
  }) async {
    final int index = _items.indexWhere((item) => item.id == id);
    final TransactionRequest updated = _items[index].copyWith(status: status);
    _items[index] = updated;
    return updated;
  }
}

void main() {
  testWidgets('renders transactions screen and toggles to Arabic RTL', (
      WidgetTester tester,
      ) async {
    final localeRepo = _InMemoryLocaleRepository();
    final localeCubit = LocaleCubit(
      getSavedLocale: GetSavedLocaleUseCase(localeRepo),
      saveLocale: SaveLocaleUseCase(localeRepo),
    );

    final txRepo = _InMemoryTransactionsRepository();
    final transactionsCubit = TransactionsCubit(
      getTransactions: GetTransactionsUseCase(txRepo),
      createTransaction: CreateTransactionUseCase(txRepo),
      updateTransactionStatus: UpdateTransactionStatusUseCase(txRepo),
    );

    await tester.pumpWidget(
      FinancialRequestsApp(
        localeCubit: localeCubit,
        transactionsCubit: transactionsCubit,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Operational & Financial Requests'), findsOneWidget);

    await tester.tap(find.text('عربي'));
    await tester.pumpAndSettle();

    expect(find.text('الطلبات التشغيلية والمالية'), findsOneWidget);

    await transactionsCubit.close();
    await localeCubit.close();
  });
}