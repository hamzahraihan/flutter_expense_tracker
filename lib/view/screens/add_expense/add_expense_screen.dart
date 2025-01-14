import 'package:expense_tracker/view/widgets/buttons/primary_button.dart';
import 'package:expense_tracker/view/widgets/dropdown_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  static const String routeName = '/add-expense';
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _descriptionInputController =
      TextEditingController();
  final TextEditingController _dropdownButtonController =
      TextEditingController(text: 'Subscription');
  final TextEditingController _descriptionController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _descriptionInputController.dispose();
    _dropdownButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.white,
          title: const Text(
            'Expense',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.red.shade400,
        ),
        backgroundColor: Colors.red.shade400,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
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
                  controller: _descriptionInputController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == '0') {
                      return 'Please enter nominal';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(
                        mantissaLength: 0,
                        thousandSeparator: ThousandSeparator.Period)
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
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 26),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(42),
                        topRight: Radius.circular(42))),
                child: Column(
                  children: [
                    DropdownButtonWidget(
                        dropdownController:
                            _dropdownButtonController),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 2,
                      maxLength: 64,
                      decoration: InputDecoration(
                        hintText: 'Description',
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
                    PrimaryButtonWidget(
                      title: 'Submit',
                      onclick: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Processing Data')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )),
            ],
          ),
        ));
  }
}
