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
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2,
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
          widget.onClick(item);
          setState(() {
            activateButtonIndex = index;
          });
        },
        child: Text(item));
  }
}
