import 'package:shared_preferences/shared_preferences.dart';

abstract class LocaleLocalDataSource {
  String? getCachedLanguageCode();
  Future<void> cacheLanguageCode(String languageCode);
}

class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  LocaleLocalDataSourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  static const String _kLocaleKey = 'cached_locale_code';

  @override
  String? getCachedLanguageCode() {
    return _sharedPreferences.getString(_kLocaleKey);
  }

  @override
  Future<void> cacheLanguageCode(String languageCode) async {
    await _sharedPreferences.setString(_kLocaleKey, languageCode);
  }
}