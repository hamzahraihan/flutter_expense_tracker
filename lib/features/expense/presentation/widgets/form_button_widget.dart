import 'package:flutter/material.dart';

class FormButtonWidget extends StatefulWidget {
  final String title;
  final void Function()? onclick;
  final bool isButtonDisable;

  const FormButtonWidget(
      {super.key,
      required this.title,
      this.onclick,
      required this.isButtonDisable});

  @override
  State<FormButtonWidget> createState() => _FormButtonWidgetState();
}

class _FormButtonWidgetState extends State<FormButtonWidget> {
  String get title => widget.title;
  bool get isButtonDisable => widget.isButtonDisable;

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
        onPressed: isButtonDisable ? widget.onclick : null,
        child: isButtonDisable
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ));
  }
}
