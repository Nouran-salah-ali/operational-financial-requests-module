import 'package:financial_requests_module/core/localization/l10n_extension.dart';
import 'package:financial_requests_module/core/theme/app_colors.dart';
import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/presentation/widgets/status_badge.dart';
import 'package:material_ui/material_ui.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  final TransactionRequest transaction;
  final VoidCallback onTap;

  String _priorityLabel(BuildContext context, TransactionPriority priority) {
    return switch (priority) {
      TransactionPriority.high => context.tr.priorityHigh,
      TransactionPriority.medium => context.tr.priorityMedium,
      TransactionPriority.low => context.tr.priorityLow,
    };
  }

  String _formatDate(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);
    final ThemeData theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transaction.title,
                          style: theme.textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          '${context.tr.referenceLabel}: ${transaction.referenceId}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  StatusBadge(status: transaction.status),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Divider(color: colors.border, height: 1),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${transaction.amount.toStringAsFixed(2)} ${transaction.currency}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colors.primaryBrand,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        _priorityLabel(context, transaction.priority),
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        _formatDate(transaction.createdAt),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}