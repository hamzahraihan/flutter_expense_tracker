import 'package:expense_tracker/model/transactions_model.dart';
import 'package:expense_tracker/view/widgets/loading.dart';
import 'package:expense_tracker/view/widgets/recent_transactions.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});
  static const String routeName = '/expense';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionsModel>>(
        future: transactionsDataList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionsModel>> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.isNotEmpty) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final transactions = snapshot.data!;
            final List<TransactionsModel> todayTransactions =
                Transactions.filterTransactionsByDate(transactions)
                    .today;
            final List<TransactionsModel> yesterdayTransactions =
                Transactions.filterTransactionsByDate(transactions)
                    .yesterady;
            final List<TransactionsModel> thisWeekTransactions =
                Transactions.filterTransactionsByDate(transactions)
                    .thisWeek;
            final List<TransactionsModel> thisMonthTransaction =
                Transactions.filterTransactionsByDate(transactions)
                    .thisMonth;
            final List<TransactionsModel> olderTransactions =
                Transactions.filterTransactionsByDate(transactions)
                    .older;
            return Scaffold(
                appBar: AppBar(
                  forceMaterialTransparency: true,
                  centerTitle: true,
                  title: const Text(
                    'Transactions',
                    style: TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ),
                body: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    Padding(
                      padding: todayTransactions.isNotEmpty
                          ? const EdgeInsets.symmetric(vertical: 8.0)
                          : const EdgeInsets.all(0),
                      child: Text(
                        todayTransactions.isNotEmpty ? 'Today' : '',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                        children: todayTransactions.map((item) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0),
                          child: RecentTransactionsWidget(
                              icon: Icons.shopping_bag,
                              title: item.title,
                              description: item.description,
                              expenseType: item.expenseType,
                              date: item.date,
                              amount: item.amount));
                    }).toList()),
                    Padding(
                      padding: yesterdayTransactions.isNotEmpty
                          ? const EdgeInsets.symmetric(vertical: 8.0)
                          : const EdgeInsets.all(0),
                      child: Text(
                        yesterdayTransactions.isNotEmpty
                            ? 'Yesterday'
                            : '',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                        children: yesterdayTransactions.map((item) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0),
                          child: RecentTransactionsWidget(
                              icon: Icons.shopping_bag,
                              title: item.title,
                              description: item.description,
                              expenseType: item.expenseType,
                              date: item.date,
                              amount: item.amount));
                    }).toList()),
                    Padding(
                      padding: thisWeekTransactions.isNotEmpty
                          ? const EdgeInsets.symmetric(vertical: 8.0)
                          : const EdgeInsets.all(0),
                      child: Text(
                        thisWeekTransactions.isNotEmpty
                            ? 'This Week'
                            : '',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                        children: thisWeekTransactions.map((item) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0),
                          child: RecentTransactionsWidget(
                              icon: Icons.shopping_bag,
                              title: item.title,
                              description: item.description,
                              expenseType: item.expenseType,
                              date: item.date,
                              amount: item.amount));
                    }).toList()),
                    Padding(
                      padding: thisMonthTransaction.isNotEmpty
                          ? const EdgeInsets.symmetric(vertical: 8.0)
                          : const EdgeInsets.all(0),
                      child: Text(
                        thisMonthTransaction.isNotEmpty
                            ? 'This Month'
                            : '',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                        children: thisMonthTransaction.map((item) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0),
                          child: RecentTransactionsWidget(
                              icon: Icons.shopping_bag,
                              title: item.title,
                              description: item.description,
                              expenseType: item.expenseType,
                              date: item.date,
                              amount: item.amount));
                    }).toList()),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Older',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                        children: olderTransactions.map((item) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0),
                          child: RecentTransactionsWidget(
                              icon: Icons.shopping_bag,
                              title: item.title,
                              description: item.description,
                              expenseType: item.expenseType,
                              date: item.date,
                              amount: item.amount));
                    }).toList()),
                  ],
                ));
          }
          return const Loading();
        });
  }
}
