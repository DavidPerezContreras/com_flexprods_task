import 'dart:convert';

import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/data/todo/remote/exception/todo_exception.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:http/http.dart' as http;

class TodoRemoteImpl {
  TodoRemoteImpl();

  Future<List<Todo>> getTodoList(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as List;
      return responseBody.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw DefaultTodoException();
    }
  }
}
