import 'package:nested_navigation/domain/model/describable_error.dart';

class DefaultTodoError extends DescribableError {
  DefaultTodoError()
      : super(
            "There was a problem fetching your tasks. Check your connection and try again.");
}
