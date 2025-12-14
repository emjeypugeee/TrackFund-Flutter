import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/logic/blocs/user/user_bloc.dart';
import 'package:track_fund/logic/blocs/user_wallets/wallet_bloc.dart';
import 'package:drift/drift.dart' hide Column;

class AddNewWalletForm extends StatefulWidget {
  final UserWallet? walletToEdit;
  const AddNewWalletForm({super.key, this.walletToEdit});

  @override
  State<AddNewWalletForm> createState() => _AddNewWalletFormState();
}

class _AddNewWalletFormState extends State<AddNewWalletForm> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _holderNameController = TextEditingController();
  final _lastFourDigitController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Check if we are in "Edit Mode"
    if (widget.walletToEdit != null) {
      final w = widget.walletToEdit!;
      _nameController.text = w.walletName;
      _balanceController.text = w.walletBalance.toString();
      _holderNameController.text = w.holderName;
      _lastFourDigitController.text = w.lastFourDigit ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _holderNameController.dispose();
    _lastFourDigitController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final userState = context.read<UserBloc>().state;

      if (userState is UserLoginSuccess) {
        final int userId = userState.user.id;

        // --- UPDATE EXISTING WALLET ---
        if (widget.walletToEdit != null) {
          final updatedWallet = widget.walletToEdit!.copyWith(
            walletName: _nameController.text,
            walletBalance: double.parse(_balanceController.text),
            holderName: _holderNameController.text,
            lastFourDigit: Value(
              _lastFourDigitController.text.isEmpty ? null : _lastFourDigitController.text,
            ),
          );

          context.read<WalletBloc>().add(UpdateWallet(updatedWallet));
        }
        // --- ADD NEW WALLET ---
        else {
          context.read<WalletBloc>().add(
            AddWallet(
              name: _nameController.text,
              balance: double.parse(_balanceController.text),
              lastFourDigit:
                  _lastFourDigitController
                      .text,
              holderName: _holderNameController.text,
              userId: userId,
            ),
          );
        }

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handling keyboard obstruction
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Wallet',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Wallet Name Input
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Wallet Name',
                  hintText: 'e.g. GCash, Maya, Bank',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance_wallet),
                ),
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),

              // Balance Input
              TextFormField(
                controller: _balanceController,
                decoration: const InputDecoration(
                  labelText: 'Initial Balance',
                  hintText: '0.00',
                  prefixText: '₱ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  LengthLimitingTextInputFormatter(8),
                ],
                validator:
                    (value) => value == null || value.isEmpty ? 'Please enter a balance' : null,
              ),
              const SizedBox(height: 16),

              // last four digit input
              TextFormField(
                controller: _lastFourDigitController,
                decoration: const InputDecoration(
                  labelText: 'Last four digit of your card',
                  hintText: '1234',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) return null;

                  if (value.length != 4) return 'Must be 4 digits';

                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _holderNameController,
                decoration: const InputDecoration(
                  labelText: 'Holder Name',
                  hintText: 'e.g. Juan Dela Cruz',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator:
                    (value) => value == null || value.isEmpty ? 'Please enter a holder name' : null,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: () => _submitForm(), child: const Text('Save Wallet')),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
