import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  static const String routeName = '/add-expense';
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'How much?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Flexible(
                        child: Text(
                          'Rp.',
                          style: TextStyle(
                              color: Colors.white, fontSize: 32.0),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 32.0),
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0),
                              hintText: '0',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.all(20),
                height: 630,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(42),
                        topRight: Radius.circular(42))),
                child: const Text('data'),
              ),
            ],
          ),
        ));
  }
}
