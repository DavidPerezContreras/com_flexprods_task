import 'package:test/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:test/di/service_locator.dart';
import 'package:test/domain/model/todo.dart';
import 'package:test/domain/repository/todo_repository.dart';
import 'package:test/service/secure_storage_service.dart';

class CreateTodoUseCase {
  final TodoRepository _todoRepository = locator<TodoRepository>();
  final SecureStorageService _storageService = locator<SecureStorageService>();

  Future<Todo> createTodo(CreateTodoRequest createTodoRequest) async {
    String? token = await _storageService.getToken();
    return await _todoRepository.createTodo(createTodoRequest, token??"");
    }
}
