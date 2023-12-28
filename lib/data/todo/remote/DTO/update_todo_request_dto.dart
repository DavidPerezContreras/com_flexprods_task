class UpdateTodoRequest {
  final int id;
  final String title;
  final String description;
  final bool isComplete;
  final int userId;
  final DateTime? dueDate;

  UpdateTodoRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
    required this.userId,
    this.dueDate,
  });

  factory UpdateTodoRequest.fromJson(Map<String, dynamic> json) {
    return UpdateTodoRequest(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isComplete: json['isComplete'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isComplete': isComplete,
      'userId': userId,
      'dueDate': dueDate?.toIso8601String(),
    };
  }

  UpdateTodoRequest copyWith({
    int? id,
    String? title,
    String? description,
    bool? isComplete,
    int? userId,
    DateTime? dueDate,
  }) {
    return UpdateTodoRequest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isComplete: isComplete ?? this.isComplete,
      userId: userId ?? this.userId,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
