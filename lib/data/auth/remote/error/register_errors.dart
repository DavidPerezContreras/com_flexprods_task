import 'package:nested_navigation/domain/model/describable_error.dart';

class UnauthorizedRegisterError extends DescribableError {
  UnauthorizedRegisterError()
      : super(
            "There's already an user with that username. Please choose another one.");
}

class DefaultRegisterError extends DescribableError {
  DefaultRegisterError()
      : super(
            "There was a problem with the register. Check your connection and try again.");
}
