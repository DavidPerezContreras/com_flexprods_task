import 'package:nested_navigation/domain/model/describable_error.dart';

class DefaultGetTodoListError extends DescribableError {
  DefaultGetTodoListError()
      : super(
            "There was a problem fetching your tasks. Check your connection and try again.");
}

class DefaultCreateTodoError extends DescribableError {
  DefaultCreateTodoError()
      : super(
            "There was a problem creating your task. Check your connection and try again.");
}

class DefaultUpdateTodoError extends DescribableError {
  DefaultUpdateTodoError()
      : super(
            "There was a problem editing your task. Check your connection and try again.");
}

class DefaultDeleteTodoError extends DescribableError {
  DefaultDeleteTodoError()
      : super(
            "There was a problem deleting your task. Check your connection and try again.");
}
