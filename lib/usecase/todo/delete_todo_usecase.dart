import 'package:test/di/service_locator.dart';
import 'package:test/domain/model/todo.dart';
import 'package:test/domain/repository/todo_repository.dart';
import 'package:test/service/secure_storage_service.dart';

class DeleteTodoUseCase {
  final TodoRepository _todoRepository = locator<TodoRepository>();
  final SecureStorageService _storageService = locator<SecureStorageService>();

  Future<void> deleteTodo(Todo todo) async {
    String? token = await _storageService.getToken();
    await _todoRepository.deleteTodo(todo, token??"");
    }
}
