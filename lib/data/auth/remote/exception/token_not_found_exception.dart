class TokenNotFoundException implements Exception {
  final String message =
      "Token Not found. Redirect user to Login page.";

  @override
  String toString() => "TokenNotFoundException: $message";
}
