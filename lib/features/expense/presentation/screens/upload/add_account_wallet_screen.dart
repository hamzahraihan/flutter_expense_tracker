import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_state.dart';

import 'package:expense_tracker/features/expense/presentation/widgets/form_button_widget.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/select_wallet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AddAccountWalletScreen extends StatefulWidget {
  const AddAccountWalletScreen({super.key});
  static const String routeName = '/add-account-wallet';

  @override
  State<AddAccountWalletScreen> createState() =>
      _AddAccountWalletState();
}

class _AddAccountWalletState extends State<AddAccountWalletScreen> {
  final String intialWalletType = 'Wallet type';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
        builder: (BuildContext context, AccountState state) {
      print(state.props);
      final Orientation orientation =
          MediaQuery.of(context).orientation;
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            foregroundColor: Colors.white,
            title: const Text(
              'Add new account',
              style: TextStyle(fontSize: 18.0),
            ),
            backgroundColor: Colors.deepPurple,
          ),
          backgroundColor: Colors.deepPurple,
          body: orientation == Orientation.portrait
              ? _buildBody()
              : _buildBodyLandscape());
    });
  }

  _buildBody() {
    final Orientation orientation =
        MediaQuery.of(context).orientation;

    Future<void> handleSubmitExpense() async {
      // Validate returns true if the form is valid, or false otherwise.
      if (_formKey.currentState!.validate()) {
        // Map<String, dynamic> transactionUserInput = {
        //   'title': _selectedDropdownValue,
        //   'category': _selectedDropdownValue,
        //   'description': _descriptionController.text,
        //   'amount':
        //       int.tryParse(_amountTransactionController.text) ?? 0,
        //   'date': DateTime.now(),
        //   'expenseType': 'expense'
        // };

        // If the form is valid, display a snackbar. In the real world,
        // you'd often call a server or save the information in a database.
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(
        //   const SnackBar(
        //       content: Text('Processing Data')),
        // );
        try {
          context
              .read<AccountBloc>()
              .add(const AddAccountWalletSubmitted());

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account added')));
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saving data failed!')));
          }
          throw Exception('Error $e');
        }
      }
    }

    Widget handleSpacer = orientation == Orientation.portrait
        ? const Spacer()
        : const SizedBox();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          handleSpacer,
          const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                'Balance',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 12.0),
            child: TextFormField(
              onChanged: (value) {
                final int amount = int.tryParse(value) ?? 0;
                context
                    .read<AccountBloc>()
                    .add(AccountBalanceChanged(amount));
              },
              validator: (value) {
                if (value == null || value.isEmpty || value == '0') {
                  return 'Please enter nominal';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                // CurrencyInputFormatter(
                //     mantissaLength: 0,
                //     thousandSeparator: ThousandSeparator.Period)
              ],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  errorStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                  errorBorder: InputBorder.none,
                  prefixIcon: const Text(
                    'Rp. ',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: '0',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none)),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 26,
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(42),
                      topRight: Radius.circular(42))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10.0,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        context
                            .read<AccountBloc>()
                            .add(AccountNameChanged(value));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter wallet name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Ex: Shopping wallet etc.',
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black26),
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black26),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const Text(
                      'Bank',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SelectedWallet(),
                    FormButtonWidget(
                      title: 'Submit',
                      onclick: handleSubmitExpense,
                    )
                  ]))
        ],
      ),
    );
  }

  _buildBodyLandscape() {
    return SingleChildScrollView(primary: true, child: _buildBody());
  }
}
