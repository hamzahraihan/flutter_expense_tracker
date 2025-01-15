import 'package:expense_tracker/model/transactions_model.dart';
import 'package:expense_tracker/services/firebase.dart';
import 'package:expense_tracker/view/screens/transactions/transactions_list.dart';
import 'package:expense_tracker/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/view/screens/add_expense/add_expense_screen.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  static const String routeName = '/expense';

  @override
  State<TransactionsScreen> createState() =>
      _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _key = GlobalKey<ExpandableFabState>();

  void _handleExpandableNavigation(BuildContext context, screen) {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => screen));
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        transactionsDataList();
      });
    }
  }

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
            return const Text(
                "You never do any transactions, atleast for now.");
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
              body: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0),
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
                      ])),
              floatingActionButtonLocation: ExpandableFab.location,
              floatingActionButton: ExpandableFab(
                  type: ExpandableFabType.side,
                  key: _key,
                  overlayStyle: const ExpandableFabOverlayStyle(
                      color: Colors.black38),
                  openButtonBuilder:
                      RotateFloatingActionButtonBuilder(
                    child: const Icon(Icons.add),
                    fabSize: ExpandableFabSize.regular,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                  ),
                  closeButtonBuilder:
                      RotateFloatingActionButtonBuilder(
                    child: const Icon(Icons.close),
                    fabSize: ExpandableFabSize.regular,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    shape: const CircleBorder(),
                  ),
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'expense button',
                      tooltip: 'expense',
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red.shade500,
                      onPressed: () => _handleExpandableNavigation(
                          context, const AddExpenseScreen()),
                      child: const Icon(Icons.trending_down),
                    ),
                    FloatingActionButton.small(
                      heroTag: 'income button',
                      tooltip: 'income',
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green.shade500,

                      // TODO MAKE AN ADD INCOME SCREEN
                      onPressed: () => _handleExpandableNavigation(
                          context, const Placeholder()),
                      child: const Icon(Icons.trending_up),
                    ),
                  ]),
            );
          }
          return const Loading();
        });
  }
}
