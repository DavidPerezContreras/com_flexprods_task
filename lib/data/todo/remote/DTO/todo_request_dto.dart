class CreateTodoRequest {
  final String title;
  final String description;
  final DateTime? dueDate;

  CreateTodoRequest({
    required this.title,
    required this.description,
    this.dueDate,
  });

  factory CreateTodoRequest.fromJson(Map<String, dynamic> json) {
    return CreateTodoRequest(
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
    };
  }

  CreateTodoRequest copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
  }) {
    return CreateTodoRequest(
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
