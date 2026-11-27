import 'package:financial_requests_module/app.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/data/datasources/locale_local_datasource.dart';
import 'core/localization/data/repositories/locale_repository_impl.dart';
import 'core/localization/domain/usecases/get_saved_locale_usecase.dart';
import 'core/localization/domain/usecases/save_locale_usecase.dart';
import 'core/localization/presentation/cubit/locale_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final LocaleLocalDataSource localDataSource = LocaleLocalDataSourceImpl(prefs);
  final LocaleRepositoryImpl localeRepository =
  LocaleRepositoryImpl(localDataSource);
  final GetSavedLocaleUseCase getSavedLocale =
  GetSavedLocaleUseCase(localeRepository);
  final SaveLocaleUseCase saveLocale = SaveLocaleUseCase(localeRepository);

  final LocaleCubit localeCubit = LocaleCubit(
    getSavedLocale: getSavedLocale,
    saveLocale: saveLocale,
  );
  await localeCubit.loadSavedLocale();

  runApp(FinancialRequestsApp(localeCubit: localeCubit));
}