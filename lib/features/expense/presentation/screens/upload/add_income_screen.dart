import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_state.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/dropdown_button_widget.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/form_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});
  static const String routeName = '/add-income';
  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String intialCategoryValue = 'Subscription';

  @override
  Widget build(BuildContext context) {
    context
        .read<AddTransactionBloc>()
        .add(const AddTransactionExpenseTypeChanged('income'));

    final Orientation orientation =
        MediaQuery.of(context).orientation;

    return BlocBuilder<AddTransactionBloc, AddTransactionState>(
        builder: (BuildContext context, AddTransactionState state) {
      return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            foregroundColor: Colors.white,
            title: const Text(
              'Income',
              style: TextStyle(fontSize: 18.0),
            ),
            backgroundColor: Colors.green.shade400,
          ),
          backgroundColor: Colors.green.shade400,
          body: orientation == Orientation.portrait
              ? _buildBody()
              : _buildBodyLandscape());
    });
  }

  _buildBody() {
    final Orientation orientation =
        MediaQuery.of(context).orientation;

    Future<void> handleSubmitIncome() async {
      // Validate returns true if the form is valid, or false otherwise.
      if (_formKey.currentState!.validate()) {
        // If the form is valid, display a snackbar. In the real world,
        // you'd often call a server or save the information in a database.
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(
        //   const SnackBar(
        //       content: Text('Processing Data')),
        // );
        try {
          context
              .read<AddTransactionBloc>()
              .add(const AddTransactionSubmitted());
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transaction added')));
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saving data failed!')));
          }
        throw Exception('error: $e');
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
                'How much?',
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
                    .read<AddTransactionBloc>()
                    .add(AddTransactionAmountChanged(amount));
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
              child: Column(children: [
                DropdownButtonWidget(
                  initialValue: intialCategoryValue,
                  onSelected: (value) {
                    context
                        .read<AddTransactionBloc>()
                        .add(AddTransactionCategoryChanged(value));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    context
                        .read<AddTransactionBloc>()
                        .add(AddTransactionDescriptionChanged(value));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  maxLines: 2,
                  maxLength: 64,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormButtonWidget(
                  title: 'Submit',
                  onclick: handleSubmitIncome,
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
