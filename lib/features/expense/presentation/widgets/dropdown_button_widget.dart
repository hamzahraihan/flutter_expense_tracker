import 'dart:collection';

import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<String> dropdownList;
  final String initialValue;
  final ValueChanged<String?>? onSelected;

  const DropdownButtonWidget(
      {super.key,
      required this.initialValue,
      required this.dropdownList,
      required this.onSelected});

  @override
  State<DropdownButtonWidget> createState() =>
      _DropdownButtonWidgetState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  List<String> get list => widget.dropdownList;

  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.initialValue;
    super.initState();
    context
        .read<AddTransactionBloc>()
        .add(AddTransactionCategoryChanged(widget.initialValue));
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuEntry> menuEntries =
        UnmodifiableListView<MenuEntry>(list.map<MenuEntry>(
            (String name) => MenuEntry(value: name, label: name)));

    return DropdownMenu(
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(16)))),
      width: double.infinity,
      initialSelection: dropdownValue,
      dropdownMenuEntries: menuEntries,
      enableSearch: false,
      onSelected: widget.onSelected,
    );
  }
}
