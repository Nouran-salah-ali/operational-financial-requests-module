import 'package:financial_requests_module/core/localization/l10n_extension.dart';
import 'package:financial_requests_module/core/theme/app_colors.dart';
import 'package:financial_requests_module/core/theme/app_spacing.dart';
import 'package:financial_requests_module/core/widgets/responsive_container.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:financial_requests_module/features/transactions/presentation/cubit/transactions_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() => _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _selectedCurrency = 'SAR';
  TransactionPriority _selectedPriority = TransactionPriority.medium;

  static const List<String> _currencies = <String>['SAR', 'USD', 'EUR'];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String _priorityLabel(BuildContext context, TransactionPriority priority) {
    return switch (priority) {
      TransactionPriority.high => context.tr.priorityHigh,
      TransactionPriority.medium => context.tr.priorityMedium,
      TransactionPriority.low => context.tr.priorityLow,
    };
  }

  Future<void> _submit(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final double amount = double.parse(_amountController.text.trim());
    final bool created = await context.read<TransactionsCubit>().createTransaction(
      title: _titleController.text.trim(),
      amount: amount,
      currency: _selectedCurrency,
      priority: _selectedPriority,
      notes: _notesController.text.trim(),
    );

    if (created && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colors = AppColorsExtension.of(context);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.createRequestTitle),
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
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: context.tr.requestTitleLabel,
                      hintText: context.tr.requestTitleHint,
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr.titleRequiredError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: context.tr.amountLabel,
                            hintText: '0.00',
                          ),
                          validator: (String? value) {
                            final double? parsed =
                            double.tryParse(value?.trim() ?? '');
                            if (parsed == null || parsed <= 0) {
                              return context.tr.amountInvalidError;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCurrency,
                          decoration: InputDecoration(
                            labelText: context.tr.currencyLabel,
                          ),
                          items: _currencies
                              .map(
                                (String currency) => DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency),
                            ),
                          )
                              .toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() => _selectedCurrency = value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    context.tr.priorityLabel,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    children:
                    TransactionPriority.values.map((TransactionPriority p) {
                      final bool selected = _selectedPriority == p;
                      return ChoiceChip(
                        label: Text(_priorityLabel(context, p)),
                        selected: selected,
                        onSelected: (_) =>
                            setState(() => _selectedPriority = p),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: context.tr.notesLabel,
                      hintText: context.tr.notesHint,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  FilledButton(
                    onPressed:
                    state.isSubmitting ? null : () => _submit(context),
                    child: state.isSubmitting
                        ? SizedBox(
                      height: AppSpacing.md,
                      width: AppSpacing.md,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.surface,
                      ),
                    )
                        : Text(context.tr.submitRequestButton),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}