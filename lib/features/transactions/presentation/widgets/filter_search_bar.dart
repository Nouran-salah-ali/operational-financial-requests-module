import 'package:financial_requests_module/core/localization/l10n_extension.dart';
import 'package:financial_requests_module/core/theme/app_colors.dart';
import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:material_ui/material_ui.dart';

class FilterSearchBar extends StatelessWidget {
  const FilterSearchBar({
    super.key,
    required this.searchQuery,
    required this.selectedStatus,
    required this.onSearchChanged,
    required this.onStatusSelected,
    this.controller,
  });

  final String searchQuery;
  final TransactionStatus? selectedStatus;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<TransactionStatus?> onStatusSelected;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);
    final ThemeData theme = Theme.of(context);

    final List<(TransactionStatus? status, String label)> filters =
    <(TransactionStatus?, String)>[
      (null, context.tr.filterAll),
      (TransactionStatus.completed, context.tr.filterCompleted),
      (TransactionStatus.pending, context.tr.filterPending),
      (TransactionStatus.rejected, context.tr.filterRejected),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          controller: controller,
          onChanged: onSearchChanged,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: context.tr.searchHint,
            hintStyle: theme.textTheme.bodySmall,
            prefixIcon: Icon(
              Icons.search,
              color: colors.textSecondary,
            ),
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
              onPressed: () {
                controller?.clear();
                onSearchChanged('');
              },
              icon: Icon(
                Icons.close,
                color: colors.textSecondary,
              ),
            )
                : null,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map(((TransactionStatus?, String) item) {
              final (TransactionStatus? status, String label) = item;
              final bool isSelected = selectedStatus == status;

              return Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                child: ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) => onStatusSelected(status),
                  selectedColor: colors.primaryBrand,
                  backgroundColor: colors.surface,
                  side: BorderSide(
                    color: isSelected ? colors.primaryBrand : colors.border,
                  ),
                  labelStyle: theme.textTheme.labelLarge?.copyWith(
                    color: isSelected ? colors.surface : colors.textPrimary,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}