import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Add intl package for date formatting
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/logic/blocs/user_wallets/wallet_bloc.dart';

class AddExpensesForm extends StatefulWidget {
  const AddExpensesForm({super.key});

  @override
  State<AddExpensesForm> createState() => _AddExpensesFormState();
}

class _AddExpensesFormState extends State<AddExpensesForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  // State Variables
  int? _selectedWalletId;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  // Hardcoded categories (Move to a constant file or DB later)
  final List<String> _categories = [
    'Food & Dining',
    'Transportation',
    'Utilities',
    'Shopping',
    'Entertainment',
    'Health',
    'Others',
  ];

  @override
  void initState() {
    super.initState();
    // Set initial date text
    _dateController.text = DateFormat('MMM dd, yyyy').format(_selectedDate);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Helper to pick date
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(), // Cannot pick future dates for expenses
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MMM dd, yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Media query for responsive bottom sheet
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding + 20, // Add extra padding for safety
        top: 16,
        right: 16,
        left: 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Add Expense',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent, // Red for expenses
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state) {
                  if (state is WalletLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is WalletLoaded) {
                    if (state.wallets.isEmpty) {
                      return const Center(child: Text("Please add a wallet first."));
                    }

                    // Validation Logic
                    final isValueInList = state.wallets.any((w) => w.id == _selectedWalletId);
                    final currentSelection = isValueInList ? _selectedWalletId : null;

                    UserWallet? selectedWallet;
                    if (currentSelection != null) {
                      try {
                        selectedWallet = state.wallets.firstWhere((w) => w.id == currentSelection);
                      } catch (_) {}
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 1. WALLET SELECTION
                        DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Pay from Wallet',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                          ),
                          initialValue: currentSelection,
                          items:
                              state.wallets.map((wallet) {
                                return DropdownMenuItem<int>(
                                  value: wallet.id,
                                  child: Text(wallet.walletName),
                                );
                              }).toList(),
                          onChanged: (value) => setState(() => _selectedWalletId = value),
                          validator: (value) => value == null ? 'Select a wallet' : null,
                        ),

                        // 2. COMPACT WALLET CARD (Replaces the 3 text fields)
                        if (selectedWallet != null)
                          _buildCompactWalletCard(context, selectedWallet),

                        const SizedBox(height: 20),

                        // 3. EXPENSE NAME
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'e.g. Lunch, Taxi',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description_outlined),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => value!.isEmpty ? 'Enter description' : null,
                          inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        ),

                        const SizedBox(height: 16),

                        // 4. AMOUNT & CATEGORY ROW
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Amount Field
                            Expanded(
                              flex: 3, // Takes 60% of width
                              child: TextFormField(
                                controller: _amountController,
                                decoration: const InputDecoration(
                                  labelText: 'Amount',
                                  prefixText: '₱ ',
                                  border: OutlineInputBorder(),
                                  prefixStyle: TextStyle(color: Colors.red),
                                ),
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                  LengthLimitingTextInputFormatter(8),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Required';

                                  final amount = double.tryParse(value);

                                  if (amount == null) return 'Invalid';

                                  if (selectedWallet != null) {
                                    if (amount > selectedWallet.walletBalance) {
                                      return 'Exceeds balance';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Category Field
                            Expanded(
                              flex: 2, // Takes 40% of width
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'Category',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                ),
                                initialValue: _selectedCategory,
                                items:
                                    _categories.map((cat) {
                                      return DropdownMenuItem(
                                        value: cat,
                                        child: Text(
                                          cat,
                                          style: const TextStyle(fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (val) => setState(() => _selectedCategory = val),
                                validator: (val) => val == null ? 'Required' : null,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // 5. DATE PICKER
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: _pickDate,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("Error loading wallets");
                },
              ),

              const SizedBox(height: 32),

              // SUBMIT BUTTON
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.check),
                label: const Text("Confirm Expense"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final amount = double.parse(_amountController.text);
                    context.read<WalletBloc>().add(
                      AddExpenses(
                        walletId: _selectedWalletId!,
                        amount: amount,
                        description: _descriptionController.text,
                        category: _selectedCategory!,
                        date: _selectedDate,
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A nicer, compact way to show wallet details
  Widget _buildCompactWalletCard(BuildContext context, UserWallet wallet) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Balance",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              Text(
                "₱ ${wallet.walletBalance.toStringAsFixed(2)}",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                wallet.holderName,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "•••• ${wallet.lastFourDigit}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
