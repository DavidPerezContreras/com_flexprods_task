import '../../../../domain/model/descriptable_error.dart';

class UnauthorizedLoginError extends DescriptableError {
  UnauthorizedLoginError() : super("Incorrect username or password.");
}

class DefaultLoginError extends DescriptableError {
  DefaultLoginError()
      : super(
            "There was a problem logging in. Check your connection and try again.");
}

