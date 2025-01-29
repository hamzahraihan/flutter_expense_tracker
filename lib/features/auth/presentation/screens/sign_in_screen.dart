import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state.authStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text('Authentication failure')));
        }
        return _buildBody(context, state);
      },
    );
  }

  Scaffold _buildBody(BuildContext context, AuthState state) {
    return Scaffold(
        body: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          TextFormField(
            onChanged: (value) {
              // context
              //     .read<AddTransactionBloc>()
              //     .add(AddTransactionDescriptionChanged(value));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter description';
              }
              return null;
            },
            maxLines: 1,
            maxLength: 64,
            decoration: InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(16)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          ElevatedButton.icon(
            key: const Key('loginForm_googleLogin_raisedButton'),
            label: const Text(
              'SIGN IN WITH GOOGLE',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            icon: const Icon(FontAwesomeIcons.google,
                color: Colors.white),
            onPressed: () => context
                .read<SignInBloc>()
                .add(const SignInWithGoogle()),
          )
        ],
      ),
    ));
  }
}
