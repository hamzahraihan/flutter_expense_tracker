import 'package:flutter/material.dart';

class AccountWalletWidget extends StatefulWidget {
  final String wallet;
  const AccountWalletWidget({super.key, required this.wallet});

  @override
  State<AccountWalletWidget> createState() =>
      _AccountWalletWidgetState();
}

class _AccountWalletWidgetState extends State<AccountWalletWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey.shade200,
      ),
      padding: const EdgeInsets.all(13.0),
      width: double.infinity,
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(widget.wallet), const Text('Rp.20.000')],
      ),
    );
  }
}
