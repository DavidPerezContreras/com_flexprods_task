import 'dart:ffi';

class Todo {
  final int id;
  final String title;
  final String description;
  final bool isComplete;
  final DateTime dueDate;
  final int userId;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
    required this.dueDate,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isComplete: json['isComplete'],
      dueDate: DateTime.parse(json['dueDate']),
      userId: json['userId'],
    );
  }
}
