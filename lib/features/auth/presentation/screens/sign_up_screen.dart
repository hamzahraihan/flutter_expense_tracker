import 'dart:async';

import 'package:expense_tracker/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_up/sign_up_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_up/sign_up_state.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/status.dart';
import 'package:expense_tracker/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Timer? debounce;

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
        listener: (BuildContext context, SignUpState state) {
      if (state.formStatus.invalid) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
              content: Text(
                  'Invalid form: please fill in or correct the invalid all fields')));
      }
    }, builder: (context, state) {
      return _buildBody(context, state, debounce);
    });
  }

  Scaffold _buildBody(
      BuildContext context, SignUpState state, debounce) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Sign Up',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        body: Form(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              TextFormField(
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce =
                      Timer(const Duration(milliseconds: 500), () {
                    context
                        .read<SignUpBloc>()
                        .add(UsernameChanged(value));
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.length < 8) {
                    return 'Username must be at least 8 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  errorText:
                      state.usernameStatus == UsernameStatus.invalid
                          ? 'Username must be at least 8 characters'
                          : null,
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce =
                      Timer(const Duration(milliseconds: 500), () {
                    context
                        .read<SignUpBloc>()
                        .add(EmailChanged(value));
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  errorText: state.emailStatus == EmailStatus.invalid
                      ? 'invalid email'
                      : null,
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              TextFormField(
                key: const Key('signUp_passwordInput_textField'),
                obscureText: true,
                onChanged: (value) {
                  context
                      .read<SignUpBloc>()
                      .add(PasswordChanged(value));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  errorText:
                      state.passwordStatus == PasswordStatus.invalid
                          ? 'invalid password'
                          : null,
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              ElevatedButton.icon(
                key: const Key('signUpWithCredential'),
                label: const Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(double.infinity, 50)),
                icon: const Icon(Icons.login, color: Colors.white),
                onPressed: () {
                  context
                      .read<SignUpBloc>()
                      .add(const SignUpWithEmailAndPassword());
                },
              ),
              const Divider(),
              const Text(
                'Or with',
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                key: const Key('signUp_googleSignup_raisedButton'),
                label: state.formStatus.submissionInProgress
                    ? const CircularProgressIndicator()
                    : const Text(
                        'SIGN UP WITH GOOGLE',
                        style: TextStyle(color: Colors.white),
                      ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(double.infinity, 50)),
                icon: const Icon(FontAwesomeIcons.google,
                    color: Colors.white),
                onPressed: state.formStatus.submissionInProgress
                    ? null
                    : () => context
                        .read<SignUpBloc>()
                        .add(const SignUpWithGoogle()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 0,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context)
                        ..pushNamed(SignInScreen.routeName),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        )));
  }
}
