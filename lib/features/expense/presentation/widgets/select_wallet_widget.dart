import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_event.dart';
import 'package:expense_tracker/features/expense/presentation/screens/account/account_screen.dart';
import 'package:expense_tracker/features/expense/presentation/util/svg_selection.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedWallet extends StatefulWidget {
  const SelectedWallet({super.key});

  @override
  State<SelectedWallet> createState() => _SelectedWalletState();
}

class _SelectedWalletState extends State<SelectedWallet> {
  int? activateButtonIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(const AccountTypeChanged(''));
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation =
        MediaQuery.of(context).orientation;

    return GridView.count(

        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        mainAxisSpacing: orientation == Orientation.portrait ? 5 : 10,
        crossAxisSpacing: 5,
        shrinkWrap: true,
        childAspectRatio: orientation == Orientation.portrait ? 2 : 6,
        // Generate 100 widgets that display their index in the List.
        children: wallets.asMap().entries.map((entry) {
          int index = entry.key + 1;
          String wallet = entry.value;
          return _selectWalletWidget(context, index, wallet);
        }).toList());
  }

  Widget _selectWalletWidget(
      BuildContext context, int index, String wallet) {
    final bool isActive = activateButtonIndex == index;
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Colors.deepPurple.shade50,
          shape: RoundedRectangleBorder(
              borderRadius:
                  const BorderRadius.all(Radius.circular(10)),
              side: isActive
                  ? const BorderSide(color: Colors.deepPurpleAccent)
                  : BorderSide.none)),
      onPressed: () {
        setState(() {
          activateButtonIndex = index;
        });
        context.read<AccountBloc>().add(AccountTypeChanged(wallet));
      },
      child: SvgSelection(svgName: wallet),
    );
  }
}
