// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Operational & Financial Requests';

  @override
  String get languageToggleLabel => 'عربي';

  @override
  String get searchHint => 'Search by title or reference ID...';

  @override
  String get filterAll => 'All';

  @override
  String get filterCompleted => 'Completed';

  @override
  String get filterPending => 'Pending';

  @override
  String get filterRejected => 'Rejected';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityLow => 'Low';

  @override
  String get newRequest => 'New Request';

  @override
  String get retry => 'Retry';

  @override
  String get emptyTitle => 'No matching requests';

  @override
  String get emptySubtitle =>
      'Try adjusting your search query or status filter.';

  @override
  String get errorTitle => 'Unable to load requests';

  @override
  String get referenceLabel => 'Ref';

  @override
  String get amountLabel => 'Amount';

  @override
  String get dateLabel => 'Date';

  @override
  String get priorityLabelText => 'Priority';

  @override
  String get notesLabel => 'Notes';

  @override
  String get noNotes => 'No additional notes';

  @override
  String get updateStatus => 'Update Status';

  @override
  String get createRequestTitle => 'Create New Request';

  @override
  String get titleFieldLabel => 'Request Title';

  @override
  String get amountFieldLabel => 'Amount';

  @override
  String get notesFieldLabel => 'Notes (Optional)';

  @override
  String get submit => 'Submit Request';

  @override
  String get titleRequiredError => 'Request title is required';

  @override
  String get amountInvalidError => 'Enter a valid amount greater than 0';

  @override
  String get step3ReadyMessage => 'Step 3 Ready — Theme & RTL/LTR Localization';
}
