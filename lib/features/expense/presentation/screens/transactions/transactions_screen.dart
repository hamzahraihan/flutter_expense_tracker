import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_expense_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_list.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_income_screen.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Future<void> _refreshData(state) async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        state;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TransactionFirebaseBloc>();
    bloc.add(const GetTransaction());

    return BlocBuilder<TransactionFirebaseBloc,
            TransactionFirebaseState>(
        builder:
            (BuildContext context, TransactionFirebaseState state) {
      switch (state.status) {
        case TransactionStatus.failure:
          return const Text("Something went wrong");
        case TransactionStatus.loading:
          return const Loading();
        case TransactionStatus.success:
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
                onRefresh: () => _refreshData(state.transactions),
                child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      TransactionsList(
                        transactionData: state.todayTransactions,
                        dateTitle: 'Today',
                      ),
                      TransactionsList(
                        transactionData: state.yesterdayTransactions,
                        dateTitle: 'Yesterdays',
                      ),
                      TransactionsList(
                        transactionData: state.thisWeekTransactions,
                        dateTitle: 'This Week',
                      ),
                      TransactionsList(
                        transactionData: state.thisMonthTransaction,
                        dateTitle: 'This Month',
                      ),
                      TransactionsList(
                        transactionData: state.olderTransactions,
                        dateTitle: 'Older',
                      ),
                    ])),
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: ExpandableFab(
                type: ExpandableFabType.side,
                key: _key,
                overlayStyle: const ExpandableFabOverlayStyle(
                    color: Colors.black38),
                openButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(Icons.add),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                ),
                closeButtonBuilder: RotateFloatingActionButtonBuilder(
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
                        context, const AddIncomeScreen()),
                    child: const Icon(Icons.trending_up),
                  ),
                ]),
          );
        default:
          return const Center(child: Text('Welcome to Transactions'));
      }
    });
  }
}
