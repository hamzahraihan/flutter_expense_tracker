import 'dart:collection';

import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<String> dropdownList;
  final String initialValue;
  final ValueChanged<String> onSelected;
  const DropdownButtonWidget(
      {super.key,
      required this.initialValue,
      required this.onSelected,
      required this.dropdownList});

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
    super.initState();
    dropdownValue = widget.initialValue;
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
