import 'package:nested_navigation/domain/model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodoList(String token);
}
