import 'package:test/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:test/data/todo/remote/DTO/update_todo_request_dto.dart';
import 'package:test/domain/model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodoList(String token);

  Future<Todo> createTodo(CreateTodoRequest createTodoRequest, String token);

  Future<Todo> updateTodo(UpdateTodoRequest updateTodoRequest, String token);

  Future<void> deleteTodo(Todo todo, String token);
}
