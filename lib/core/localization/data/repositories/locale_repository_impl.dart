import 'package:flutter/material.dart';

import '../../domain/repositories/locale_repository.dart';
import '../datasources/locale_local_datasource.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  LocaleRepositoryImpl(this._localDataSource);

  final LocaleLocalDataSource _localDataSource;

  @override
  Future<Locale> getSavedLocale() async {
    final String? cachedCode = _localDataSource.getCachedLanguageCode();
    if (cachedCode == 'ar' || cachedCode == 'en') {
      return Locale(cachedCode!);
    }
    return const Locale('en');
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await _localDataSource.cacheLanguageCode(locale.languageCode);
  }
}