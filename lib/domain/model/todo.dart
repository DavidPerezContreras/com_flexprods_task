class Todo {
  final int id;
  final String title;
  final String description;
  final bool isComplete;
  final int userId;
  final DateTime? dueDate;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
    required this.userId,
    this.dueDate,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isComplete: json['isComplete'],
      dueDate:  DateTime.parse(json['dueDate']) ,
      userId: json['userId'],
    );
  }
}
