
import 'dart:ui';

import '../repositories/locale_repository.dart';

class SaveLocaleUseCase {
  const SaveLocaleUseCase(this._repository);

  final LocaleRepository _repository;

  Future<void> call(Locale locale) => _repository.saveLocale(locale);
}