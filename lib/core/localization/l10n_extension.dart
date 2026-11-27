import 'package:financial_requests_module/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);
}