import 'package:financial_requests_module/core/localization/l10n_extension.dart';
import 'package:financial_requests_module/core/theme/app_colors.dart';
import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:material_ui/material_ui.dart';

class LoadingStateView extends StatelessWidget {
  const LoadingStateView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: CircularProgressIndicator(
          color: colors.primaryBrand,
        ),
      ),
    );
  }
}

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    this.onResetFilters,
  });

  final VoidCallback? onResetFilters;

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: AppSpacing.minTouchTarget + 16,
              height: AppSpacing.minTouchTarget + 16,
              decoration: BoxDecoration(
                color: colors.containerBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inbox_outlined,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              context.tr.emptyTitle,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              context.tr.emptySubtitle,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (onResetFilters != null) ...<Widget>[
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: onResetFilters,
                child: Text(context.tr.filterAll),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    super.key,
    required this.onRetry,
    this.message,
  });

  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: AppSpacing.minTouchTarget + 16,
              height: AppSpacing.minTouchTarget + 16,
              decoration: BoxDecoration(
                color: colors.rejectedBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                color: colors.rejectedFg,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              context.tr.errorTitle,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (message != null && message!.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppSpacing.xxs),
              Text(
                message!,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.tr.retry),
            ),
          ],
        ),
      ),
    );
  }
}