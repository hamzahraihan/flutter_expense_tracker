import 'dart:async';

import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/status.dart';
import 'package:expense_tracker/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Timer? debounce;

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (BuildContext context, SignInState state) {
        if (state.formStatus.invalid) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(
                    'Invalid form: please fill in or correct the invalid all fields')));
        }

        // give an error notification if user failed to sign in
        if (state.formStatus.submissionFailure &&
            state.errorType.userNotFound) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text('No user found with this email')));
        }
        if (state.formStatus.submissionFailure &&
            state.errorType.wrongPassword) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text('Wrong password!')));
        }
      },
      builder: (BuildContext context, SignInState state) {
        return _buildBody(context, state, debounce);
      },
    );
  }

  Scaffold _buildBody(
      BuildContext context, SignInState state, debounce) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Sign In',
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
                        .read<SignInBloc>()
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
                key: const Key('signIn_passwordInput_textField'),
                obscureText: true,
                onChanged: (value) {
                  context
                      .read<SignInBloc>()
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
                key: const Key('loginWithCredential'),
                label: const Text(
                  'SIGN IN',
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
                      .read<SignInBloc>()
                      .add(const SignInWithEmailAndPassword());
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
                key: const Key('loginForm_googleLogin_raisedButton'),
                label: state.formStatus.submissionInProgress
                    ? const CircularProgressIndicator()
                    : const Text(
                        'SIGN IN WITH GOOGLE',
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
                        .read<SignInBloc>()
                        .add(const SignInWithGoogle()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 0,
                children: [
                  const Text(
                    'Don’t have an account yet?',
                    style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context)
                        ..pushNamed(SignUpScreen.routeName),
                      child: const Text(
                        'Sign Up',
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
