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
  String get searchHint => 'ابحثي بالعنوان أو رقم المرجع...';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterCompleted => 'مكتمل';

  @override
  String get filterPending => 'قيد الانتظار';

  @override
  String get filterRejected => 'مرفوض';

  @override
  String get priorityHigh => 'عالية';

  @override
  String get priorityMedium => 'متوسطة';

  @override
  String get priorityLow => 'منخفضة';

  @override
  String get newRequest => 'New Request';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get emptyTitle => 'لا توجد طلبات';

  @override
  String get emptySubtitle =>
      'لا توجد طلبات تشغيلية أو مالية مطابقة في الوقت الحالي.';

  @override
  String get errorTitle => 'حدث خطأ غير متوقع';

  @override
  String get referenceLabel => 'رقم المرجع';

  @override
  String get amountLabel => 'المبلغ';

  @override
  String get dateLabel => 'Date';

  @override
  String get priorityLabelText => 'Priority';

  @override
  String get notesLabel => 'الملاحظات';

  @override
  String get noNotes => 'No additional notes';

  @override
  String get updateStatus => 'Update Status';

  @override
  String get createRequestTitle => 'إنشاء طلب جديد';

  @override
  String get titleFieldLabel => 'Request Title';

  @override
  String get amountFieldLabel => 'Amount';

  @override
  String get notesFieldLabel => 'Notes (Optional)';

  @override
  String get submit => 'Submit Request';

  @override
  String get titleRequiredError => 'عنوان الطلب مطلوب.';

  @override
  String get amountInvalidError => 'أدخلي مبلغاً صحيحاً أكبر من الصفر.';

  @override
  String get step3ReadyMessage => 'Step 3 Ready — Theme & RTL/LTR Localization';

  @override
  String get newRequestButton => 'طلب جديد';

  @override
  String get detailsTitle => 'تفاصيل الطلب';

  @override
  String get priorityLabel => 'الأولوية';

  @override
  String get createdAtLabel => 'تاريخ الإنشاء';

  @override
  String get noNotesPlaceholder => 'لا توجد ملاحظات إضافية.';

  @override
  String get updateStatusLabel => 'تحديث الحالة';

  @override
  String get statusUpdatedSuccess => 'تم تحديث حالة الطلب بنجاح.';

  @override
  String get requestTitleLabel => 'عنوان الطلب';

  @override
  String get requestTitleHint => 'أدخلي عنواناً واضحاً للطلب';

  @override
  String get currencyLabel => 'العملة';

  @override
  String get notesHint => 'أضيفي تفاصيل أو مبررات إضافية (اختياري)';

  @override
  String get submitRequestButton => 'إرسال الطلب';
}
