import 'package:financial_requests_module/core/localization/l10n_extension.dart';

import 'package:financial_requests_module/core/theme/app_theme.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:financial_requests_module/features/transactions/presentation/screens/transactions_list_screen.dart';
import 'package:financial_requests_module/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    hide GlobalMaterialLocalizations;
import 'package:material_ui/material_ui.dart' hide TextDirection;

import 'core/localization/presentation/cubit/locale_cubit.dart';
import 'core/localization/presentation/cubit/locale_state.dart';

class FinancialRequestsApp extends StatelessWidget {
  const FinancialRequestsApp({
    super.key,
    required this.localeCubit,
    required this.transactionsCubit,
  });

  final LocaleCubit localeCubit;
  final TransactionsCubit transactionsCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<LocaleCubit>.value(value: localeCubit),
        BlocProvider<TransactionsCubit>.value(value: transactionsCubit),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (BuildContext context, LocaleState localeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: localeState.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
              GlobalWidgetsLocalizations.delegate,
            ],
            builder: (BuildContext context, Widget? child) {
              return Directionality(
                textDirection: localeState.textDirection,
                child: child ?? const SizedBox.shrink(),
              );
            },
            onGenerateTitle: (BuildContext context) => context.tr.appTitle,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: const TransactionsListScreen(),
          );
        },
      ),
    );
  }
}