class DefaultTodoException implements Exception {
  final String message =
      "There was a problem fetching your tasks. Check your connection and try again.";

  @override
  String toString() => "DefaultTodoException: $message";
}
