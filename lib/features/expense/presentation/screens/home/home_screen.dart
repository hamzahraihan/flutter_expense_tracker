import 'package:expense_tracker/features/expense/domain/entitiy/transaction_entities.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_screen.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/buttons/primary_button.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/chart/bar_chart.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/income_expenses_card_widget.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/loading.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/recent_transactions.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // Future<void> _refreshData(state) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   setState(() {
  //     state;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
          return _buildTransactions(state);
        default:
          return const Center(child: Text('Welcome to Transactions'));
      }
    });
  }

  final AppBar _appBar = AppBar(
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

  _buildTransactions(state) {
    // filteredThisWeekExpenses will filter weekly transaction and can be only get expense transaction
    Iterable<TransactionsModel> filteredThisWeekExpenses(
        ExpenseType expenseType) {
      if (state.thisWeekTransactions.isEmpty) {
        return [];
      }
      return state.thisWeekTransactions
          .where((element) => element.expenseType == expenseType);
    }

    int totalWeeklyExpense(ExpenseType expenseType) {
      return filteredThisWeekExpenses(expenseType).fold(
          0, (int sum, TransactionsModel item) => sum + item.amount);
    }

    int totalAmount = state.olderTransactions
        .fold(0, (sum, TransactionsModel item) => sum + item.amount);

    String convertToIdr(int totalAmount) {
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp', decimalDigits: 2)
          .format(totalAmount);
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<TransactionFirebaseBloc>()
              .add(const GetTransaction());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBar,
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
                padding:
                    const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 16.0),
                crossAxisSpacing: 10,
                shrinkWrap: true,
                childAspectRatio: 2,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  IncomeExpensesCardWidget(
                    title: 'Income',
                    amount: totalWeeklyExpense(ExpenseType.income),
                    icon: Icons.arrow_downward,
                    color: const Color.fromRGBO(0, 168, 107, 100),
                  ),
                  IncomeExpensesCardWidget(
                    title: 'Expense',
                    amount: totalWeeklyExpense(ExpenseType.expense),
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
                child: BarChartWidget(
                  filteredThisWeekExpenses:
                      filteredThisWeekExpenses(ExpenseType.expense),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      PrimaryButtonWidget(
                        title: 'See All',
                        onclick: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TransactionsScreen()));
                          });
                        },
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Column(
                    children: state.todayTransactions.isNotEmpty
                        ? state.todayTransactions
                            .take(5)
                            .map<Widget>((item) {
                            return Column(
                              children: [
                                RecentTransactionsWidget(
                                  title: item.title,
                                  description: item.description,
                                  date: item.date,
                                  expenseType: item.expenseType,
                                  amount: item.amount,
                                  category: item.category,
                                ),
                                const SizedBox(
                                    height: 8.0), // Add spacing here
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
                                    fontSize: 12,
                                    color: Colors.black38),
                              ),
                            )
                          ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
