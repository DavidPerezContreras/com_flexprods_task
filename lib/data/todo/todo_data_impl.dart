import 'package:nested_navigation/data/todo/remote/todo_remote_impl.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/domain/repository/todo_repository.dart';

class TodoDataImpl extends TodoRepository {
  final TodoRemoteImpl _todoRemoteImpl;

  TodoDataImpl(this._todoRemoteImpl);

  @override
  Future<List<Todo>> getTodoList(String token) {
    return _todoRemoteImpl.getTodoList(token);
  }
}
