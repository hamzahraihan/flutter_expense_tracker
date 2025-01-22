import 'package:expense_tracker/features/expense/presentation/widgets/account_wallet_widget.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static const String routeName = 'Account';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
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
            // Your refresh logic here
          });
          return;
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: const [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 64),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Account Balance',
                      style: TextStyle(
                          color: Colors.black38, fontSize: 14),
                    )),
                    Center(
                        child: Text(
                      'Rp. 20.000',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32),
                    ))
                  ],
                )),
            AccountWalletWidget()
          ],
        ),
      ),
    );
  }
}
