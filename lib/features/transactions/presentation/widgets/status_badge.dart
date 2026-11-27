import 'package:financial_requests_module/core/localization/l10n_extension.dart';
import 'package:financial_requests_module/core/theme/app_colors.dart';
import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:material_ui/material_ui.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
  });

  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);
    final ThemeData theme = Theme.of(context);

    final (Color bgColor, Color fgColor, String label) = switch (status) {
      TransactionStatus.completed => (
      colors.completedBg,
      colors.completedFg,
      context.tr.filterCompleted,
      ),
      TransactionStatus.pending => (
      colors.pendingBg,
      colors.pendingFg,
      context.tr.filterPending,
      ),
      TransactionStatus.rejected => (
      colors.rejectedBg,
      colors.rejectedFg,
      context.tr.filterRejected,
      ),
    };//

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs + 2,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        border: Border.all(color: fgColor.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: fgColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}