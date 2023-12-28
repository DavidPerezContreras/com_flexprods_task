class UnauthorizedLoginException implements Exception {
  final String message = "Incorrect username or password.";

  @override
  String toString() => "UnauthorizedLoginException: $message";
}

class DefaultLoginException implements Exception {
  final String message =
      "There was a problem logging in. Check your connection and try again.";

  @override
  String toString() => "DefaultLoginException: $message";
}
