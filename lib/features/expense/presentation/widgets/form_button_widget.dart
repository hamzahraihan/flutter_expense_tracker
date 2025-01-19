import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormButtonWidget extends StatefulWidget {
  final String title;
  final VoidCallback? onclick;

  const FormButtonWidget({
    super.key,
    required this.title,
    this.onclick,
  });

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

    final status = context
        .select((TransactionFirebaseBloc bloc) => bloc.state.status);

    return TextButton(
        style: textButtonStyle,
        onPressed: status.isLoading ? null : widget.onclick,
        child: status.isLoading
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
