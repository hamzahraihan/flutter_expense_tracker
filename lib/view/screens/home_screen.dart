import 'package:expense_tracker/model/transactions_model.dart';
import 'package:expense_tracker/view/widgets/buttons/primary_button.dart';
import 'package:expense_tracker/view/widgets/chart/bar_chart.dart';
import 'package:expense_tracker/view/widgets/income_expenses_card_widget.dart';
import 'package:expense_tracker/view/widgets/recent_transactions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, brightness: Brightness.light),
        fontFamily: GoogleFonts.inter().fontFamily,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      surfaceTintColor: Colors.black45,
      scrolledUnderElevation: 4.0,
      forceMaterialTransparency: true,
      centerTitle: true,
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(widget.title, style: const TextStyle(fontSize: 14.0)),
      ),
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          )),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ))
      ],
    );
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(child: appBar),
          const SizedBox(height: 16.0),
          const Center(
            child: Text('Account Balances'),
          ),
          const Center(
            child: Text(
              '\$9000',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
            ),
          ),
          GridView.count(
            padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 16.0),
            crossAxisSpacing: 10,
            shrinkWrap: true,
            childAspectRatio: 2,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: const [
              IncomeExpensesCardWidget(
                title: 'Income',
                amount: 2000,
                icon: Icons.arrow_downward,
                color: Color.fromRGBO(0, 168, 107, 100),
              ),
              IncomeExpensesCardWidget(
                title: 'Expense',
                amount: 2000,
                icon: Icons.arrow_upward,
                color: Colors.red,
              )
            ],
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 16.0),
              child: Text(
                'Spend Frequency',
                style: TextStyle(fontWeight: FontWeight.w600),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            child: BarChartWidget(),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  PrimaryButtonWidget(title: 'See All')
                ],
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: Column(
                children: transactionsDataList.map((item) {
                  return RecentTransactionsWidget(
                      icon: Icons.shopping_cart,
                      title: item.title,
                      description: item.description);
                }).toList(),
              )),
        ],
      ),
    ));
  }
}
