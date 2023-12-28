import 'package:nested_navigation/data/todo/remote/DTO/todo_request_dto.dart';
import 'package:nested_navigation/data/todo/remote/todo_remote_impl.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/domain/repository/todo_repository.dart';

class TodoDataImpl extends TodoRepository {
  final TodoRemoteImpl _todoRemoteImpl;

  TodoDataImpl(this._todoRemoteImpl);

  @override
  Future<List<Todo>> getTodoList(String token) async {
    return _todoRemoteImpl.getTodoList(token);
  }

  @override
  Future<Todo> createTodo(CreateTodoRequest createTodoRequest, String token) async {
    return _todoRemoteImpl.createTodo(createTodoRequest, token);
  }

  @override
  Future<Todo> updateTodo(Todo todo, String token) async {
    return _todoRemoteImpl.updateTodo(todo, token);
  }

  @override
  Future<Todo> deleteTodo(Todo todo, String token) {
    return _todoRemoteImpl.deleteTodo(todo, token);
  }
}
