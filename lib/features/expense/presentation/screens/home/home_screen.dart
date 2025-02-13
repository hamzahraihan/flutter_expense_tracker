import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/domain/entity/transaction_entities.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_screen.dart';
import 'package:expense_tracker/widgets/buttons/primary_button.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/chart/bar_chart.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/income_expenses_card_widget.dart';
import 'package:expense_tracker/widgets/loading.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/recent_transactions.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final AuthUserEntities authUser;
  const HomeScreen({super.key, required this.authUser});
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
          return _buildTransactions(context, state);
        default:
          return const Center(child: Text('Welcome to Transactions'));
      }
    });
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
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
        child:
            const Text('Expense', style: TextStyle(fontSize: 14.0)),
      ),
      leading: TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Are you sure?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 30),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  12)),
                                      backgroundColor:
                                          Colors.blue.shade50),
                                  onPressed: () =>
                                      Navigator.pop(context),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 16),
                                  )),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 30),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  12)),
                                      backgroundColor:
                                          Colors.blueAccent),
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(const SignOutPressed());
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: CircleAvatar(
            backgroundImage: widget.authUser.imageUrl != null
                ? NetworkImage(widget.authUser.imageUrl!)
                : null,
          )),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ))
      ],
    );
  }

  Widget _buildTransactions(
      BuildContext context, TransactionFirebaseState state) {
    // Get user account balances from AccountBloc
    final List<AccountWalletModel>? accountWallet = context
        .select((AccountBloc bloc) => bloc.state.accountWallet);

    // get a total of user account balances
    int accountBalance = accountWallet!.fold(
        0, (int sum, AccountWalletModel item) => sum + item.balance);

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

    String convertToIdr(int totalAmount) {
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp', decimalDigits: 2)
          .format(totalAmount);
    }

    return Scaffold(
      appBar: _appBar(context),
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
              const SizedBox(height: 16.0),
              const Center(
                child: Text('Account Balances'),
              ),
              Center(
                child: Text(
                  convertToIdr(accountBalance),
                  style: TextStyle(
                      fontSize: accountBalance > 1000000 ? 26 : 32,
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
                    color: Colors.green.shade400,
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
                                        TransactionsScreen(
                                            authUser:
                                                widget.authUser)));
                          });
                        },
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Column(
                    children: state.thisWeekTransactions.isNotEmpty
                        ? state.thisWeekTransactions
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
                                "You haven't doing any transaction this week!",
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
