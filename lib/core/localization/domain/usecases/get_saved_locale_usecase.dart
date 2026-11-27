
import 'dart:ui';

import '../repositories/locale_repository.dart';

class GetSavedLocaleUseCase {
  const GetSavedLocaleUseCase(this._repository);

  final LocaleRepository _repository;

  Future<Locale> call() => _repository.getSavedLocale();
}