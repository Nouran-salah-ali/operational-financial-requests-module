import 'package:financial_requests_module/core/localization/l10n_extension.dart';
import 'package:financial_requests_module/core/theme/app_theme.dart';
import 'package:financial_requests_module/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    hide GlobalMaterialLocalizations;
import 'package:material_ui/material_ui.dart';

import 'core/localization/presentation/cubit/locale_cubit.dart';
import 'core/localization/presentation/cubit/locale_state.dart';

class FinancialRequestsApp extends StatelessWidget {
  const FinancialRequestsApp({
    super.key,
    required this.localeCubit,
  });

  final LocaleCubit localeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>.value(
      value: localeCubit,
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
            home: const _LocalizationPreviewPage(),
          );
        },
      ),
    );
  }
}

class _LocalizationPreviewPage extends StatelessWidget {
  const _LocalizationPreviewPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.appTitle),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.read<LocaleCubit>().toggleLocale(),
            child: Text(context.tr.languageToggleLabel),
          ),
        ],
      ),
      body: Center(
        child: Text(context.tr.step3ReadyMessage),
      ),
    );
  }
}