import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/logic/blocs/sign_up/sign_up_cubit.dart';

class AddWalletForm extends StatefulWidget {
  const AddWalletForm({super.key});

  @override
  State<AddWalletForm> createState() => _AddWalletFormState();
}

class _AddWalletFormState extends State<AddWalletForm> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _holderNameController = TextEditingController();
  final _lastFourDigitController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _holderNameController.dispose();
    _lastFourDigitController.dispose();
    super.dispose();
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
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
              textCapitalization: TextCapitalization.sentences,
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
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
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

            // Holder Name
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
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = _nameController.text;
                  final balance = double.tryParse(_balanceController.text) ?? 0.0;
                  final holderName = _holderNameController.text;
                  final lastFourDigit = _lastFourDigitController.text;

                  context.read<SignUpCubit>().addTempWallet(
                    name: name,
                    balance: balance,
                    holderName: holderName,
                    lastFourDigit: lastFourDigit,
                  );

                  Navigator.pop(context);
                }
              },
              child: const Text('Save Wallet'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
