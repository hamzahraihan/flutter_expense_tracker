import 'package:expense_tracker/model/transactions_model.dart';
import 'package:expense_tracker/services/firebase.dart';
import 'package:expense_tracker/view/screens/transactions/transactions_list.dart';
import 'package:expense_tracker/view/widgets/loading.dart';
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
                      TransactionsList(
                        transactionData: todayTransactions,
                        dateTitle: 'Today',
                      ),
                      TransactionsList(
                        transactionData: yesterdayTransactions,
                        dateTitle: 'Yesterdays',
                      ),
                      TransactionsList(
                        transactionData: thisWeekTransactions,
                        dateTitle: 'This Week',
                      ),
                      TransactionsList(
                        transactionData: thisMonthTransaction,
                        dateTitle: 'This Month',
                      ),
                      TransactionsList(
                        transactionData: olderTransactions,
                        dateTitle: 'Older',
                      ),
                    ]));
          }
          return const Loading();
        });
  }
}
