import 'package:financial_requests_module/core/theme/app_colors.dart';
import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:financial_requests_module/core/theme/app_typography.dart';
import 'package:material_ui/material_ui.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    final AppColorsExtension colors = AppColorsExtension.light();
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: colors.primaryBrand,
      brightness: Brightness.light,
      primary: colors.primaryBrand,
      secondary: colors.secondaryBrand,
      surface: colors.background,
      error: colors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.background,
      textTheme: AppTypography.buildTextTheme(colors),
      extensions: <ThemeExtension<dynamic>>[colors],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        surfaceTintColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: BorderSide(color: colors.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colors.primaryBrand, width: 1.5),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final AppColorsExtension colors = AppColorsExtension.dark();
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: colors.primaryBrand,
      brightness: Brightness.dark,
      primary: colors.primaryBrand,
      secondary: colors.secondaryBrand,
      surface: colors.background,
      error: colors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.background,
      textTheme: AppTypography.buildTextTheme(colors),
      extensions: <ThemeExtension<dynamic>>[colors],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        surfaceTintColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: BorderSide(color: colors.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colors.primaryBrand, width: 1.5),
        ),
      ),
    );
  }
}
