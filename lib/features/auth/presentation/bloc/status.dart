enum FormStatus {
  initial,
  valid,
  invalid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

enum ErrorStatus { initial, wrongPassword, userNotFound }

enum UsernameStatus { unknown, valid, invalid }

enum EmailStatus { unknown, valid, invalid }

enum PasswordStatus { unknown, valid, invalid }
