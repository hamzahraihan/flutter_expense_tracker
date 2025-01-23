import 'package:expense_tracker/features/expense/presentation/util/svg_selection.dart';
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
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
              height: double.infinity,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: SvgSelection(svgName: widget.wallet),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.wallet)
          ]),
          const Text('Rp.20.000')
        ],
      ),
    );
  }
}
