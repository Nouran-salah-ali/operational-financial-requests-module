import 'package:financial_requests_module/app.dart';
import 'package:financial_requests_module/core/localization/domain/repositories/locale_repository.dart';
import 'package:financial_requests_module/core/localization/domain/usecases/get_saved_locale_usecase.dart';
import 'package:financial_requests_module/core/localization/domain/usecases/save_locale_usecase.dart';
import 'package:financial_requests_module/core/localization/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _InMemoryLocaleRepository implements LocaleRepository {
  Locale _saved = const Locale('en');

  @override
  Future<Locale> getSavedLocale() async => _saved;

  @override
  Future<void> saveLocale(Locale locale) async {
    _saved = locale;
  }
}

void main() {
  testWidgets('renders localization preview and toggles to Arabic RTL', (
      WidgetTester tester,
      ) async {
    final repository = _InMemoryLocaleRepository();
    final cubit = LocaleCubit(
      getSavedLocale: GetSavedLocaleUseCase(repository),
      saveLocale: SaveLocaleUseCase(repository),
    );

    await tester.pumpWidget(FinancialRequestsApp(localeCubit: cubit));
    await tester.pumpAndSettle();

    expect(find.text('Operational & Financial Requests'), findsOneWidget);

    await tester.tap(find.text('عربي'));
    await tester.pumpAndSettle();

    expect(find.text('الطلبات التشغيلية والمالية'), findsOneWidget);
    await cubit.close();
  });
}