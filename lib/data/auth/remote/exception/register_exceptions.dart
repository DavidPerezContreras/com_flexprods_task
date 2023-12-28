class UnauthorizedRegisterException implements Exception {
  final String message =
      "There's already an user with that username. Please choose another one.";

  @override
  String toString() => "UnauthorizedRegisterException: $message";
}

class DefaultRegisterException implements Exception {
  final String message =
      "There was a problem logging in. Check your connection and try again.";

  @override
  String toString() => "DefaultRegisterException: $message";
}
