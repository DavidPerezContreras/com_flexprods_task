import 'package:nested_navigation/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:nested_navigation/domain/model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodoList(String token);

  Future<Todo> createTodo(CreateTodoRequest createTodoRequest, String token);

  Future<Todo> updateTodo(Todo todo, String token);

  Future<Todo> deleteTodo(Todo todo, String token);
}
