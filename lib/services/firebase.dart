import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
// Future<List<TransactionsModel>> retrieveTransactionData() async {
//   final snapshot = await db.collection('transactions').get();
//   return snapshot.docs
//       .map((doc) => TransactionsModel.fromFirestore(doc, null))
//       .toList();
// }

class SignInWithEmailAndPasswordFailure implements Exception {
  /// The associated error message.
  final String message;

  /// {@macro log_in_with_email_and_password_failure}
  const SignInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'too-many-requests':
        return const SignInWithEmailAndPasswordFailure(
            'Too many requests. Try again.');
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }

  @override
  String toString() => message;
}
