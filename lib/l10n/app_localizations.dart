import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Operational & Financial Requests'**
  String get appTitle;

  /// No description provided for @languageToggleLabel.
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get languageToggleLabel;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'ابحثي بالعنوان أو رقم المرجع...'**
  String get searchHint;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'الكل'**
  String get filterAll;

  /// No description provided for @filterCompleted.
  ///
  /// In en, this message translates to:
  /// **'مكتمل'**
  String get filterCompleted;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'قيد الانتظار'**
  String get filterPending;

  /// No description provided for @filterRejected.
  ///
  /// In en, this message translates to:
  /// **'مرفوض'**
  String get filterRejected;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'عالية'**
  String get priorityHigh;

  /// No description provided for @priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'متوسطة'**
  String get priorityMedium;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'منخفضة'**
  String get priorityLow;

  /// No description provided for @newRequest.
  ///
  /// In en, this message translates to:
  /// **'New Request'**
  String get newRequest;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'لا توجد طلبات'**
  String get emptyTitle;

  /// No description provided for @emptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'لا توجد طلبات تشغيلية أو مالية مطابقة في الوقت الحالي.'**
  String get emptySubtitle;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'حدث خطأ غير متوقع'**
  String get errorTitle;

  /// No description provided for @referenceLabel.
  ///
  /// In en, this message translates to:
  /// **'رقم المرجع'**
  String get referenceLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'المبلغ'**
  String get amountLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @priorityLabelText.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityLabelText;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'الملاحظات'**
  String get notesLabel;

  /// No description provided for @noNotes.
  ///
  /// In en, this message translates to:
  /// **'No additional notes'**
  String get noNotes;

  /// No description provided for @updateStatus.
  ///
  /// In en, this message translates to:
  /// **'Update Status'**
  String get updateStatus;

  /// No description provided for @createRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'إنشاء طلب جديد'**
  String get createRequestTitle;

  /// No description provided for @titleFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Request Title'**
  String get titleFieldLabel;

  /// No description provided for @amountFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountFieldLabel;

  /// No description provided for @notesFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notesFieldLabel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submit;

  /// No description provided for @titleRequiredError.
  ///
  /// In en, this message translates to:
  /// **'عنوان الطلب مطلوب.'**
  String get titleRequiredError;

  /// No description provided for @amountInvalidError.
  ///
  /// In en, this message translates to:
  /// **'أدخلي مبلغاً صحيحاً أكبر من الصفر.'**
  String get amountInvalidError;

  /// No description provided for @step3ReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Step 3 Ready — Theme & RTL/LTR Localization'**
  String get step3ReadyMessage;

  /// No description provided for @newRequestButton.
  ///
  /// In en, this message translates to:
  /// **'طلب جديد'**
  String get newRequestButton;

  /// No description provided for @detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'تفاصيل الطلب'**
  String get detailsTitle;

  /// No description provided for @priorityLabel.
  ///
  /// In en, this message translates to:
  /// **'الأولوية'**
  String get priorityLabel;

  /// No description provided for @createdAtLabel.
  ///
  /// In en, this message translates to:
  /// **'تاريخ الإنشاء'**
  String get createdAtLabel;

  /// No description provided for @noNotesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'لا توجد ملاحظات إضافية.'**
  String get noNotesPlaceholder;

  /// No description provided for @updateStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'تحديث الحالة'**
  String get updateStatusLabel;

  /// No description provided for @statusUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'تم تحديث حالة الطلب بنجاح.'**
  String get statusUpdatedSuccess;

  /// No description provided for @requestTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'عنوان الطلب'**
  String get requestTitleLabel;

  /// No description provided for @requestTitleHint.
  ///
  /// In en, this message translates to:
  /// **'أدخلي عنواناً واضحاً للطلب'**
  String get requestTitleHint;

  /// No description provided for @currencyLabel.
  ///
  /// In en, this message translates to:
  /// **'العملة'**
  String get currencyLabel;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'أضيفي تفاصيل أو مبررات إضافية (اختياري)'**
  String get notesHint;

  /// No description provided for @submitRequestButton.
  ///
  /// In en, this message translates to:
  /// **'إرسال الطلب'**
  String get submitRequestButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
