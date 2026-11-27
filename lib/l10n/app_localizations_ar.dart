// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'الطلبات التشغيلية والمالية';

  @override
  String get languageToggleLabel => 'EN';

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
  String get newRequest => 'طلب جديد';

  @override
  String get retry => 'Retry';

  @override
  String get emptyTitle => 'No requests found';

  @override
  String get emptySubtitle =>
      'There are no matching operational or financial requests right now.';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get referenceLabel => 'Reference';

  @override
  String get amountLabel => 'Amount';

  @override
  String get dateLabel => 'التاريخ';

  @override
  String get priorityLabelText => 'الأولوية';

  @override
  String get notesLabel => 'Notes';

  @override
  String get noNotes => 'لا توجد ملاحظات إضافية';

  @override
  String get updateStatus => 'تحديث الحالة';

  @override
  String get createRequestTitle => 'Create New Request';

  @override
  String get titleFieldLabel => 'عنوان الطلب';

  @override
  String get amountFieldLabel => 'المبلغ';

  @override
  String get notesFieldLabel => 'ملاحظات (اختياري)';

  @override
  String get submit => 'إرسال الطلب';

  @override
  String get titleRequiredError => 'Request title is required.';

  @override
  String get amountInvalidError => 'Enter a valid amount greater than zero.';

  @override
  String get step3ReadyMessage => 'الخطوة ٣ جاهزة — الثيم والتعريب RTL/LTR';

  @override
  String get newRequestButton => 'New Request';

  @override
  String get detailsTitle => 'Request Details';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get createdAtLabel => 'Created At';

  @override
  String get noNotesPlaceholder => 'No additional notes provided.';

  @override
  String get updateStatusLabel => 'Update Status';

  @override
  String get statusUpdatedSuccess => 'Request status updated successfully.';

  @override
  String get requestTitleLabel => 'Request Title';

  @override
  String get requestTitleHint => 'Enter a clear title for the request';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get notesHint => 'Add supporting details or justification (optional)';

  @override
  String get submitRequestButton => 'Submit Request';
}
