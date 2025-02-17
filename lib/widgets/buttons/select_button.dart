import 'package:flutter/material.dart';

class SelectButton extends StatefulWidget {
  final List<String> listTitle;
  final Function(String) onClick;
  const SelectButton(
      {super.key, required this.listTitle, required this.onClick});

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  String? selectedValue = 'All';
  int? activateButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        shrinkWrap: true,
        children: widget.listTitle.asMap().entries.map((
          entry,
        ) {
          int index = entry.key + 1;
          String item = entry.value;
          return _selectButtonWidget(item, index);
        }).toList());
  }

  Widget _selectButtonWidget(String item, int index) {
    return TextButton(
        onPressed: () {
          widget.onClick(item);
        },
        child: Text(item));
  }
}
