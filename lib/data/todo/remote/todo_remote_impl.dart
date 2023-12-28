import 'dart:convert';

import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:nested_navigation/data/todo/remote/DTO/update_todo_request_dto.dart';
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
      throw DefaultGetTodoListException();
    }
  }

  Future<Todo> createTodo(CreateTodoRequest createTodoRequest, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
          createTodoRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return Todo.fromJson(responseBody);
    } else {
      throw DefaultCreateTodoException();
    }
  }

  Future<Todo> updateTodo(UpdateTodoRequest updateTodoRequest, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/todos/${updateTodoRequest.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
          updateTodoRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return Todo.fromJson(responseBody);
    } else {
      throw DefaultUpdateTodoException();
    }
  }

  Future<Todo> deleteTodo(Todo todo, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/todos/${todo.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
          todo.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return Todo.fromJson(responseBody);
    } else {
      throw DefaultDeleteTodoException();
    }
  }
}
