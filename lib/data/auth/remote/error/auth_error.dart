class UnauthorizedError extends DescriptableError {
  UnauthorizedError() : super("Incorrect username or password.");
}

class DefaultError extends DescriptableError {
  DefaultError()
      : super(
            "There was a problem logging in. Check your connection and try again.");
}

class DescriptableError extends Error {
  String description;

  DescriptableError(this.description);
}
