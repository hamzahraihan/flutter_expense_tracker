import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatefulWidget {
  final String title;
  const PrimaryButtonWidget({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButtonWidget> {
  String get title => widget.title;

  void _onClick() {}

  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.purple,
      backgroundColor: Colors.purple.shade50,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
    );

    return TextButton(
        style: textButtonStyle,
        onPressed: _onClick,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ));
  }
}
