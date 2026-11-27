
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_saved_locale_usecase.dart';
import '../../domain/usecases/save_locale_usecase.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({
    required GetSavedLocaleUseCase getSavedLocale,
    required SaveLocaleUseCase saveLocale,
    Locale initialLocale = const Locale('en'),
  })  : _getSavedLocale = getSavedLocale,
        _saveLocale = saveLocale,
        super(LocaleState(locale: initialLocale));

  final GetSavedLocaleUseCase _getSavedLocale;
  final SaveLocaleUseCase _saveLocale;

  Future<void> loadSavedLocale() async {
    final Locale saved = await _getSavedLocale();
    emit(state.copyWith(locale: saved));
  }

  Future<void> changeLocale(String languageCode) async {
    if (languageCode != 'ar' && languageCode != 'en') return;
    final Locale nextLocale = Locale(languageCode);
    await _saveLocale(nextLocale);
    emit(state.copyWith(locale: nextLocale));
  }

  Future<void> toggleLocale() async {
    final String nextCode = state.isArabic ? 'en' : 'ar';
    await changeLocale(nextCode);
  }
}