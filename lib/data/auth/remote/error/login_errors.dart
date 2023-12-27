import '../../../../domain/model/describable_error.dart';

class UnauthorizedLoginError extends DescribableError {
  UnauthorizedLoginError() : super("Incorrect username or password.");
}

class DefaultLoginError extends DescribableError {
  DefaultLoginError()
      : super(
            "There was a problem logging in. Check your connection and try again.");
}

