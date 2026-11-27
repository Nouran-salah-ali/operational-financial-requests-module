import 'package:material_ui/material_ui.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.background,
    required this.surface,
    required this.primaryBrand,
    required this.secondaryBrand,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.containerBackground,
    required this.completedBg,
    required this.completedFg,
    required this.pendingBg,
    required this.pendingFg,
    required this.rejectedBg,
    required this.rejectedFg,
    required this.error,
  });

  final Color background;
  final Color surface;
  final Color primaryBrand;
  final Color secondaryBrand;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color containerBackground;

  // Status semantic tokens for operational & financial requests
  final Color completedBg;
  final Color completedFg;
  final Color pendingBg;
  final Color pendingFg;
  final Color rejectedBg;
  final Color rejectedFg;
  final Color error;

  factory AppColorsExtension.light() => const AppColorsExtension(
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    primaryBrand: Color(0xFF0F4C81),
    secondaryBrand: Color(0xFF1E6F5C),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    border: Color(0xFFE2E8F0),
    containerBackground: Color(0xFFF1F5F9),
    completedBg: Color(0xFFDCFCE7),
    completedFg: Color(0xFF15803D),
    pendingBg: Color(0xFFFEF3C7),
    pendingFg: Color(0xFFB45309),
    rejectedBg: Color(0xFFFEE2E2),
    rejectedFg: Color(0xFFB91C1C),
    error: Color(0xFFDC2626),
  );

  factory AppColorsExtension.dark() => const AppColorsExtension(
    background: Color(0xFF0B1120),
    surface: Color(0xFF111827),
    primaryBrand: Color(0xFF60A5FA),
    secondaryBrand: Color(0xFF34D399),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    border: Color(0xFF1E293B),
    containerBackground: Color(0xFF1E293B),
    completedBg: Color(0xFF14532D),
    completedFg: Color(0xFF86EFAC),
    pendingBg: Color(0xFF78350F),
    pendingFg: Color(0xFFFCD34D),
    rejectedBg: Color(0xFF7F1D1D),
    rejectedFg: Color(0xFFFCA5A5),
    error: Color(0xFFF87171),
  );

  static AppColorsExtension fallback() => AppColorsExtension.light();

  static AppColorsExtension of(BuildContext context) {
    return Theme.of(context).extension<AppColorsExtension>() ??
        AppColorsExtension.fallback();
  }

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? background,
    Color? surface,
    Color? primaryBrand,
    Color? secondaryBrand,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? containerBackground,
    Color? completedBg,
    Color? completedFg,
    Color? pendingBg,
    Color? pendingFg,
    Color? rejectedBg,
    Color? rejectedFg,
    Color? error,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primaryBrand: primaryBrand ?? this.primaryBrand,
      secondaryBrand: secondaryBrand ?? this.secondaryBrand,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      containerBackground: containerBackground ?? this.containerBackground,
      completedBg: completedBg ?? this.completedBg,
      completedFg: completedFg ?? this.completedFg,
      pendingBg: pendingBg ?? this.pendingBg,
      pendingFg: pendingFg ?? this.pendingFg,
      rejectedBg: rejectedBg ?? this.rejectedBg,
      rejectedFg: rejectedFg ?? this.rejectedFg,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
      ThemeExtension<AppColorsExtension>? other,
      double t,
      ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primaryBrand: Color.lerp(primaryBrand, other.primaryBrand, t)!,
      secondaryBrand: Color.lerp(secondaryBrand, other.secondaryBrand, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      containerBackground:
      Color.lerp(containerBackground, other.containerBackground, t)!,
      completedBg: Color.lerp(completedBg, other.completedBg, t)!,
      completedFg: Color.lerp(completedFg, other.completedFg, t)!,
      pendingBg: Color.lerp(pendingBg, other.pendingBg, t)!,
      pendingFg: Color.lerp(pendingFg, other.pendingFg, t)!,
      rejectedBg: Color.lerp(rejectedBg, other.rejectedBg, t)!,
      rejectedFg: Color.lerp(rejectedFg, other.rejectedFg, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}