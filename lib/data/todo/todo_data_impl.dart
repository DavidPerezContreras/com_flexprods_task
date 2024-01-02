import 'package:nested_navigation/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:nested_navigation/data/todo/remote/todo_remote_impl.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/domain/repository/todo_repository.dart';

import 'remote/DTO/update_todo_request_dto.dart';

class TodoDataImpl implements TodoRepository {
  final TodoRemoteImpl _todoRemoteImpl;

  TodoDataImpl(this._todoRemoteImpl);

  @override
  Future<List<Todo>> getTodoList(String token) async {
    return await _todoRemoteImpl.getTodoList(token);
  }

  @override
  Future<Todo> createTodo(
      CreateTodoRequest createTodoRequest, String token) async {
    return await _todoRemoteImpl.createTodo(createTodoRequest, token);
  }

  @override
  Future<Todo> updateTodo(
      UpdateTodoRequest updateTodoRequest, String token) async {
    return await _todoRemoteImpl.updateTodo(updateTodoRequest, token);
  }

  @override
  Future<void> deleteTodo(Todo todo, String token) async {
    await _todoRemoteImpl.deleteTodo(todo, token);
  }
}
