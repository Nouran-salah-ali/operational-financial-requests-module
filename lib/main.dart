import 'package:financial_requests_module/app.dart';
import 'package:financial_requests_module/core/localization/data/datasources/locale_local_datasource.dart';
import 'package:financial_requests_module/core/localization/data/repositories/locale_repository_impl.dart';
import 'package:financial_requests_module/core/localization/domain/usecases/get_saved_locale_usecase.dart';
import 'package:financial_requests_module/core/localization/domain/usecases/save_locale_usecase.dart';
import 'package:financial_requests_module/core/localization/presentation/cubit/locale_cubit.dart';
import 'package:financial_requests_module/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/create_transaction_usecase.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:financial_requests_module/features/transactions/domain/usecases/update_transaction_status_usecase.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final LocaleLocalDataSource localeLocalDataSource =
  LocaleLocalDataSourceImpl(prefs);
  final LocaleRepositoryImpl localeRepository =
  LocaleRepositoryImpl(localeLocalDataSource);
  final LocaleCubit localeCubit = LocaleCubit(
    getSavedLocale: GetSavedLocaleUseCase(localeRepository),
    saveLocale: SaveLocaleUseCase(localeRepository),
  );
  await localeCubit.loadSavedLocale();

  final TransactionsRepositoryImpl transactionsRepository =
  TransactionsRepositoryImpl();
  final TransactionsCubit transactionsCubit = TransactionsCubit(
    getTransactions: GetTransactionsUseCase(transactionsRepository),
    createTransaction: CreateTransactionUseCase(transactionsRepository),
    updateTransactionStatus:
    UpdateTransactionStatusUseCase(transactionsRepository),
  );

  runApp(
    FinancialRequestsApp(
      localeCubit: localeCubit,
      transactionsCubit: transactionsCubit,
    ),
  );
}