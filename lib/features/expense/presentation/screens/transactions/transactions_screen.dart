import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_expense_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_list.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_income_screen.dart';
import 'package:expense_tracker/widgets/buttons/primary_button.dart';
import 'package:expense_tracker/widgets/buttons/select_button.dart';
import 'package:expense_tracker/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionsScreen extends StatefulWidget {
  final AuthUserEntities authUser;
  const TransactionsScreen({super.key, required this.authUser});
  static const String routeName = '/expense';

  @override
  State<TransactionsScreen> createState() =>
      _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _key = GlobalKey<ExpandableFabState>();
  final List<String> _listFilterTransaction = [
    'All',
    'Today',
    'Yesterday',
    'This Week',
    'This Month',
    'Older'
  ];

  late String selectedValue = 'All';

  void _handleExpandableNavigation(BuildContext context, screen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  void updateSelectedValue(String newValue) {
    setState(() {
      selectedValue = newValue;
    });
  }

  @override
  void dispose() {
    super.dispose();
    super.deactivate();
  }

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
          return _buildBody(state);
        default:
          return const Center(child: Text('Welcome to Transactions'));
      }
    });
  }

  Widget _buildBody(TransactionFirebaseState state) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'Transactions',
          style:
              TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    enableDrag: true,
                    showDragHandle: true,
                    context: context,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16),
                        child: Column(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Filter transaction',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  PrimaryButtonWidget(
                                      title: 'Reset',
                                      onclick: () {
                                        selectedValue =
                                            _listFilterTransaction[0];
                                      })
                                ]),
                            const Text(
                              'Sort By',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SelectButton(
                              listTitle: _listFilterTransaction,
                              onClick: updateSelectedValue,
                            )
                          ],
                        ),
                      );
                    });
              },
              icon: const Icon(FontAwesomeIcons.filter)),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            context
                .read<TransactionFirebaseBloc>()
                .add(const GetTransaction());
          },
          child: state.transactions.isEmpty
              ? const Center(
                  child: Icon(
                  Icons.remove_shopping_cart,
                  size: 100,
                  color: Colors.black38,
                ))
              : Container(
                  child: _showFilteredData(state),
                )),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
          type: ExpandableFabType.up,
          key: _key,
          overlayStyle:
              const ExpandableFabOverlayStyle(color: Colors.black38),
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
              onPressed: () => _handleExpandableNavigation(
                  context, const AddIncomeScreen()),
              child: const Icon(Icons.trending_up),
            ),
          ]),
    );
  }

  _showFilteredData(TransactionFirebaseState state) {
    switch (selectedValue) {
      case 'Today':
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TransactionsList(
                transactionData: state.todayTransactions,
                dateTitle: 'Today',
              ),
            ]);
      case 'Yesterday':
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TransactionsList(
                transactionData: state.yesterdayTransactions,
                dateTitle: 'Yesterdays',
              ),
            ]);
      case 'This Week':
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TransactionsList(
                transactionData: state.thisWeekTransactions,
                dateTitle: 'This Week',
              ),
            ]);
      case 'This Month':
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TransactionsList(
                transactionData: state.thisMonthTransaction,
                dateTitle: 'This Month',
              ),
            ]);
      case 'Older':
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TransactionsList(
                transactionData: state.olderTransactions,
                dateTitle: 'Older',
              )
            ]);
      default:
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            ]);
    }
  }
}
