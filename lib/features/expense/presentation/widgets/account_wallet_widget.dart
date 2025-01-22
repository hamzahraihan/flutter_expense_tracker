import 'package:flutter/material.dart';

class AccountWalletWidget extends StatefulWidget {
  const AccountWalletWidget({super.key});

  @override
  State<AccountWalletWidget> createState() =>
      _AccountWalletWidgetState();
}

class _AccountWalletWidgetState extends State<AccountWalletWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey.shade200,
      ),
      padding: const EdgeInsets.all(13.0),
      width: double.infinity,
      height: 85,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('data'), Text('data')],
      ),
    );
  }
}
