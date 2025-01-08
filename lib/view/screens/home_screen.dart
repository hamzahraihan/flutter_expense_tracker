import 'package:expense_tracker/model/transactions_model.dart';
import 'package:expense_tracker/view/widgets/buttons/primary_button.dart';
import 'package:expense_tracker/view/widgets/chart/bar_chart.dart';
import 'package:expense_tracker/view/widgets/income_expenses_card_widget.dart';
import 'package:expense_tracker/view/widgets/recent_transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<TransactionsModel> transactions =
        Transactions.filterTransactionsByDate(transactionsDataList).today;
    final List<TransactionsModel> olderTransactions =
        Transactions.filterTransactionsByDate(transactionsDataList).older;

    int totalAmount =
        olderTransactions.fold(0, (sum, item) => sum + item.amount);

    String convertToIdr(int totalAmount) {
      return NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 2)
          .format(totalAmount);
    }

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
        child: const Text('Expense', style: TextStyle(fontSize: 14.0)),
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
        primary: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(child: appBar),
            const SizedBox(height: 16.0),
            const Center(
              child: Text('Account Balances'),
            ),
            Center(
              child: Text(
                convertToIdr(totalAmount),
                style: TextStyle(
                    fontSize: totalAmount > 1000000 ? 26 : 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 32.0),
            GridView.count(
              padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 16.0),
              crossAxisSpacing: 10,
              shrinkWrap: true,
              childAspectRatio: 2,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
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
                padding: EdgeInsets.all(16.0),
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
                  children: transactions.isNotEmpty
                      ? transactions.take(5).map<Widget>((item) {
                          return Column(
                            children: [
                              RecentTransactionsWidget(
                                icon: Icons.shopping_cart,
                                title: item.title,
                                description: item.description,
                                date: item.date,
                                expenseType: item.expenseType,
                                amount: item.amount,
                              ),
                              const SizedBox(height: 8.0), // Add spacing here
                            ],
                          );
                        }).toList()
                      : const [
                          Center(
                            child: Icon(
                              Icons.remove_shopping_cart,
                              size: 100,
                              color: Colors.black38,
                            ),
                          ),
                          Center(
                            child: Text(
                              "You haven't doing any transaction today!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black38),
                            ),
                          )
                        ]),
            ),
          ],
        ),
      ),
    );
  }
}
