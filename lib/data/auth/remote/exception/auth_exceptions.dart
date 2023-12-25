class UnauthorizedException implements Exception {
  final String message = "Incorrect username or password.";

  @override
  String toString() => "UnauthorizedException: $message";
}

class DefaultException implements Exception {
  final String message =
      "There was a problem logging in. Check your connection and try again.";

  @override
  String toString() => "DefaultException: $message";
}
