import 'package:nested_navigation/di/service_locator.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/domain/repository/todo_repository.dart';
import 'package:nested_navigation/service/secure_storage_service.dart';

class GetTodoListUseCase {
  final TodoRepository _todoRepository = locator<TodoRepository>();
  final SecureStorageService _storageService = locator<SecureStorageService>();

  Future<List<Todo>> getTodoList() async {
    String? token = await _storageService.getToken();
    if (token != null) {
      return await _todoRepository.getTodoList(token);
    } else {
      throw Exception('No token found');
    }
  }
}
