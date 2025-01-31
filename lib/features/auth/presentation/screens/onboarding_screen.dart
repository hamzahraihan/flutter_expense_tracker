import 'package:expense_tracker/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 24,
            children: [
              const Icon(
                FontAwesomeIcons.wallet,
                size: 500,
                color: Colors.black,
              ),
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      'Gain total control of your money',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    Text(
                      'Become your own money manager and make every cent count',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  spacing: 10,
                  children: [
                    ElevatedButton(
                        key: const Key('loginRaisedButton'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.white,
                            minimumSize:
                                const Size(double.infinity, 50)),
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(
                                SignInScreen.routeName),
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        )),
                    ElevatedButton(
                        key: const Key('signUpRaisedButton'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.blue.shade900,
                            minimumSize:
                                const Size(double.infinity, 50)),
                        onPressed: () => {},
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
