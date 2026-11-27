import 'package:financial_requests_module/core/localization/l10n_extension.dart';
import 'package:financial_requests_module/core/theme/app_colors.dart';
import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:financial_requests_module/core/widgets/responsive_container.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_state.dart';
import 'package:financial_requests_module/features/transactions/presentation/widgets/status_badge.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({
    super.key,
    required this.transactionId,
  });

  final String transactionId;

  String _priorityLabel(BuildContext context, TransactionPriority priority) {
    return switch (priority) {
      TransactionPriority.high => context.tr.priorityHigh,
      TransactionPriority.medium => context.tr.priorityMedium,
      TransactionPriority.low => context.tr.priorityLow,
    };
  }

  String _statusActionLabel(BuildContext context, TransactionStatus status) {
    return switch (status) {
      TransactionStatus.completed => context.tr.filterCompleted,
      TransactionStatus.pending => context.tr.filterPending,
      TransactionStatus.rejected => context.tr.filterRejected,
    };
  }

  String _formatDateTime(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    final String hour = date.hour.toString().padLeft(2, '0');
    final String minute = date.minute.toString().padLeft(2, '0');
    return '${date.year}-$month-$day  $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.detailsTitle),
      ),
      body: ResponsiveContainer(
        child: BlocConsumer<TransactionsCubit, TransactionsState>(
          listener: (BuildContext context, TransactionsState state) {
            if (state.status == TransactionsUiStatus.error &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: colors.rejectedFg,
                ),
              );
            }
          },
          builder: (BuildContext context, TransactionsState state) {
            TransactionRequest? transaction;
            for (final TransactionRequest item in state.allItems) {
              if (item.id == transactionId) {
                transaction = item;
                break;
              }
            }

            if (transaction == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    context.tr.emptyTitle,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              );
            }

            final TransactionRequest current = transaction;

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                current.title,
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            StatusBadge(status: current.status),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${context.tr.referenceLabel}: ${current.referenceId}',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          '${current.amount.toStringAsFixed(2)} ${current.currency}',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: colors.primaryBrand,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _DetailRow(
                          label: context.tr.priorityLabel,
                          value: _priorityLabel(context, current.priority),
                        ),
                        Divider(color: colors.border, height: AppSpacing.lg),
                        _DetailRow(
                          label: context.tr.createdAtLabel,
                          value: _formatDateTime(current.createdAt),
                        ),
                        Divider(color: colors.border, height: AppSpacing.lg),
                        Text(
                          context.tr.notesLabel,
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          current.notes.isNotEmpty
                              ? current.notes
                              : context.tr.noNotesPlaceholder,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: current.notes.isNotEmpty
                                ? colors.textPrimary
                                : colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  context.tr.updateStatusLabel,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: TransactionStatus.values.map((TransactionStatus target) {
                    final bool isCurrent = current.status == target;
                    return ChoiceChip(
                      label: Text(_statusActionLabel(context, target)),
                      selected: isCurrent,
                      onSelected: state.isSubmitting || isCurrent
                          ? null
                          : (_) async {
                        final bool ok = await context
                            .read<TransactionsCubit>()
                            .updateStatus(
                          id: current.id,
                          status: target,
                        );
                        if (ok && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.tr.statusUpdatedSuccess),
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
                if (state.isSubmitting) ...<Widget>[
                  const SizedBox(height: AppSpacing.md),
                  Center(
                    child: CircularProgressIndicator(color: colors.primaryBrand),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label, style: theme.textTheme.bodyMedium),
        Text(
          value,
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }
}