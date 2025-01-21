import 'dart:collection';

import 'package:flutter/material.dart';

const List<String> list = <String>[
  'Subscription',
  'Food',
  'Transportation',
  'Shopping'
];

class DropdownButtonWidget extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onSelected;
  const DropdownButtonWidget(
      {super.key,
      required this.initialValue,
      required this.onSelected});

  @override
  State<DropdownButtonWidget> createState() =>
      _DropdownButtonWidgetState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  static final List<MenuEntry> menuEntries =
      UnmodifiableListView<MenuEntry>(list.map<MenuEntry>(
          (String name) => MenuEntry(value: name, label: name)));

  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
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
      onSelected: (value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
          });
        }
        widget.onSelected(value!);
      },
    );
  }
}
