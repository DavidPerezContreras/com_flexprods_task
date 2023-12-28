import 'package:nested_navigation/domain/model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodoList(String token);

  Future<Todo> createTodo(Todo todo, String token);

  Future<Todo> updateTodo(Todo todo, String token);

  Future<Todo> deleteTodo(Todo todo, String token);
}
