import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/domain/repository/todo_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class CreateTodoUseCase {
  final TodoRepository _todoRepository = locator<TodoRepository>();
  final SecureStorageService _storageService = locator<SecureStorageService>();

  Future<Todo> createTodo(Todo todo) async {
    String? token = await _storageService.getToken();
    if (token != null) {
      return _todoRepository.createTodo(todo,token);
    } else {
      throw Exception('No token found');
    }
  }
}