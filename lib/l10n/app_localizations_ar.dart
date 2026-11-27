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
  String get searchHint => 'ابحث بالعنوان أو رقم المرجع...';

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
  String get newRequest => 'طلب جديد';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get emptyTitle => 'لا توجد طلبات مطابقة';

  @override
  String get emptySubtitle => 'جرّب تعديل كلمة البحث أو تغيير عامل التصفية.';

  @override
  String get errorTitle => 'تعذّر تحميل الطلبات';

  @override
  String get referenceLabel => 'المرجع';

  @override
  String get amountLabel => 'المبلغ';

  @override
  String get dateLabel => 'التاريخ';

  @override
  String get priorityLabelText => 'الأولوية';

  @override
  String get notesLabel => 'الملاحظات';

  @override
  String get noNotes => 'لا توجد ملاحظات إضافية';

  @override
  String get updateStatus => 'تحديث الحالة';

  @override
  String get createRequestTitle => 'إنشاء طلب جديد';

  @override
  String get titleFieldLabel => 'عنوان الطلب';

  @override
  String get amountFieldLabel => 'المبلغ';

  @override
  String get notesFieldLabel => 'ملاحظات (اختياري)';

  @override
  String get submit => 'إرسال الطلب';

  @override
  String get titleRequiredError => 'عنوان الطلب مطلوب';

  @override
  String get amountInvalidError => 'أدخل مبلغاً صحيحاً أكبر من صفر';

  @override
  String get step3ReadyMessage => 'الخطوة ٣ جاهزة — الثيم والتعريب RTL/LTR';
}
