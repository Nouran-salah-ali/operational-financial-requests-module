import 'package:financial_requests_module/core/localization/l10n_extension.dart';
import 'package:financial_requests_module/core/theme/app_colors.dart';
import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:financial_requests_module/core/widgets/responsive_container.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_state.dart';
import 'package:financial_requests_module/features/transactions/presentation/screens/create_transaction_screen.dart';
import 'package:financial_requests_module/features/transactions/presentation/screens/transaction_details_screen.dart';
import 'package:financial_requests_module/features/transactions/presentation/widgets/filter_search_bar.dart';
import 'package:financial_requests_module/features/transactions/presentation/widgets/state_views.dart';
import 'package:financial_requests_module/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/presentation/cubit/locale_cubit.dart';

class TransactionsListScreen extends StatefulWidget {
  const TransactionsListScreen({super.key});

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TransactionsCubit>().loadTransactions();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openCreateScreen(BuildContext context) async {
    final TransactionsCubit cubit = context.read<TransactionsCubit>();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider<TransactionsCubit>.value(
          value: cubit,
          child: const CreateTransactionScreen(),
        ),
      ),
    );
  }

  Future<void> _openDetailsScreen(
      BuildContext context,
      TransactionRequest transaction,
      ) async {
    final TransactionsCubit cubit = context.read<TransactionsCubit>();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider<TransactionsCubit>.value(
          value: cubit,
          child: TransactionDetailsScreen(transactionId: transaction.id),
        ),
      ),
    );
  }

  void _resetFilters(BuildContext context) {
    _searchController.clear();
    final TransactionsCubit cubit = context.read<TransactionsCubit>();
    cubit.updateSearchQuery('');
    cubit.filterByStatus(null);
  }

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.appTitle),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () => context.read<LocaleCubit>().toggleLocale(),
            icon: const Icon(Icons.language),
            label: Text(context.tr.languageToggleLabel),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreateScreen(context),
        backgroundColor: colors.primaryBrand,
        foregroundColor: colors.surface,
        icon: const Icon(Icons.add),
        label: Text(
          context.tr.newRequestButton,
          style: theme.textTheme.labelLarge?.copyWith(color: colors.surface),
        ),
      ),
      body: ResponsiveContainer(
        child: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (BuildContext context, TransactionsState state) {
            final bool hasActiveFilters = state.filterStatus != null ||
                state.searchQuery.trim().isNotEmpty;

            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: FilterSearchBar(
                    controller: _searchController,
                    searchQuery: state.searchQuery,
                    selectedStatus: state.filterStatus,
                    onSearchChanged: (String query) =>
                        context.read<TransactionsCubit>().updateSearchQuery(query),
                    onStatusSelected: (TransactionStatus? status) =>
                        context.read<TransactionsCubit>().filterByStatus(status),
                  ),
                ),
                Expanded(
                  child: switch (state.status) {
                    TransactionsUiStatus.loading => const LoadingStateView(),
                    TransactionsUiStatus.error => ErrorStateView(
                      message: state.errorMessage,
                      onRetry: () => context
                          .read<TransactionsCubit>()
                          .loadTransactions(),
                    ),
                    TransactionsUiStatus.empty => EmptyStateView(
                      onResetFilters: hasActiveFilters
                          ? () => _resetFilters(context)
                          : null,
                    ),
                    TransactionsUiStatus.success => RefreshIndicator(
                      color: colors.primaryBrand,
                      onRefresh: () => context
                          .read<TransactionsCubit>()
                          .loadTransactions(),
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.xs,
                          AppSpacing.md,
                          AppSpacing.xxl + AppSpacing.lg,
                        ),
                        itemCount: state.visibleItems.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (BuildContext context, int index) {
                          final TransactionRequest item =
                          state.visibleItems[index];
                          return TransactionCard(
                            transaction: item,
                            onTap: () => _openDetailsScreen(context, item),
                          );
                        },
                      ),
                    ),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}