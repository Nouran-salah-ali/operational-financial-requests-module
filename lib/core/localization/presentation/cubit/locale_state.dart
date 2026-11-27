import 'package:flutter/material.dart';

class LocaleState {
  const LocaleState({
    required this.locale,
  });

  final Locale locale;

  bool get isArabic => locale.languageCode == 'ar';

  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  LocaleState copyWith({Locale? locale}) {
    return LocaleState(
      locale: locale ?? this.locale,
    );
  }
}