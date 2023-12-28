class DefaultGetTodoListException implements Exception {
  final String message =
      "There was a problem fetching your tasks. Check your connection and try again.";

  @override
  String toString() => "DefaultGetTodoListException: $message";
}

class DefaultCreateTodoException implements Exception {
  final String message =
      "There was a problem creating your task. Check your connection and try again.";

  @override
  String toString() => "DefaultCreateTodoException: $message";
}

class DefaultUpdateTodoException implements Exception {
  final String message =
      "There was a problem updating your task. Check your connection and try again.";

  @override
  String toString() => "DefaultUpdateTodoException: $message";
}

class DefaultDeleteTodoException implements Exception {
  final String message =
      "There was a problem deleting your task. Check your connection and try again.";

  @override
  String toString() => "DefaultUpdateTodoException: $message";
}
