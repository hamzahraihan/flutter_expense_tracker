import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_state.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_account_wallet_screen.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/account_wallet_widget.dart';
import 'package:expense_tracker/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final List<String> wallets = [
  'Paypal',
  'Jago',
  'Mandiri',
  'BCA',
  'Citilink',
  'Bitcoin',
  'Gopay',
  'ShopeePay',
  // 'Other'
];

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static const String routeName = '/account';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void _handleFloatingButton(BuildContext context, screen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
        builder: (BuildContext context, AccountState state) {
      switch (state.status) {
        case AccountWalletStatus.loading:
          return const Loading();
        case AccountWalletStatus.failure:
          return const Text("Something went wrong");
        case AccountWalletStatus.success:
          return _buildBody(state);
        case AccountWalletStatus.initial:
          return const Center(child: Text('Welcome to Transactions'));
      }
    });
  }

  Widget _buildBody(AccountState state) {
    int totalAccountBalance = state.accountWallet!
        .fold(0, (sum, item) => sum + item.balance);

    String convertToIdr(int balance) {
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp', decimalDigits: 2)
          .format(balance);
    }

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'Account',
          style:
              TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            context.read<AccountBloc>().add(const GetAccountWallet());
          });
          return;
        },
        child: ListView(
          primary: true,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: Column(
                  children: [
                    const Center(
                        child: Text(
                      'Account Balance',
                      style: TextStyle(
                          color: Colors.black38, fontSize: 14),
                    )),
                    Center(
                        child: Text(
                      convertToIdr(totalAccountBalance),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32),
                    ))
                  ],
                )),
            ListView(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: state.accountWallet!
                  .map((item) => (AccountWalletWidget(
                        wallet: item,
                      )))
                  .toList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleFloatingButton(
            context, const AddAccountWalletScreen()),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.account_balance_wallet_rounded),
      ),
    );
  }
}
