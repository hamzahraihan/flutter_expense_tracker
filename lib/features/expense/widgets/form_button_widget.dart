import 'package:flutter/material.dart';

class FormButtonWidget extends StatefulWidget {
  final String title;
  final void Function()? onclick;

  const FormButtonWidget(
      {super.key, required this.title, this.onclick});

  @override
  State<FormButtonWidget> createState() => _FormButtonWidgetState();
}

class _FormButtonWidgetState extends State<FormButtonWidget> {
  String get title => widget.title;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      minimumSize: const Size(double.infinity, 50),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
    );

    return TextButton(
        style: textButtonStyle,
        onPressed: widget.onclick,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16),
        ));
  }
}
