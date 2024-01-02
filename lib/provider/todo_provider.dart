import 'package:flutter/material.dart';
import 'package:nested_navigation/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:nested_navigation/data/todo/remote/DTO/update_todo_request_dto.dart';
import 'package:nested_navigation/data/todo/remote/error/todo_errors.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/usecase/todo/create_todo_usecase.dart';
import 'package:nested_navigation/usecase/todo/delete_todo_usecase.dart';
import 'package:nested_navigation/usecase/todo/get_todo_list_usecase.dart';
import 'package:nested_navigation/usecase/todo/update_todo_usecase.dart';

class TodoProvider extends ChangeNotifier {
  late ResourceState<List<Todo>> _todoListState;
  late final GetTodoListUseCase _getTodoListUseCase = GetTodoListUseCase();
  late final CreateTodoUseCase _createTodoUseCase = CreateTodoUseCase();
  late final UpdateTodoUseCase _updateTodoUseCase = UpdateTodoUseCase();
  late final DeleteTodoUseCase _deleteTodoUseCase = DeleteTodoUseCase();
  ResourceState<List<Todo>> get todoListState => _todoListState;

  TodoProvider() {
    init();
  }

  void init() {
    _todoListState = ResourceState.none();
  }

  Future<void> getTodoList() async {
    _todoListState = ResourceState.loading();
    notifyListeners();
    Future.delayed(const Duration(seconds: 1));

    try {
      await fetchTodoList();
    } catch (exception) {
      _todoListState = ResourceState.error(DefaultGetTodoListError());
    }

    notifyListeners();
  }

  Future<void> createTodo(CreateTodoRequest createTodoRequest) async {
    _todoListState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      await _createTodoUseCase.createTodo(createTodoRequest);
      await fetchTodoList();
    } catch (exception) {
      _todoListState = ResourceState.error(DefaultCreateTodoError());
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> updateTodo(UpdateTodoRequest updateTodoRequest) async {
    _todoListState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      await _updateTodoUseCase.updateTodo(updateTodoRequest);
      await fetchTodoList();
    } catch (exception) {
      _todoListState = ResourceState.error(DefaultUpdateTodoError());
    }

    notifyListeners();
  }

  Future<void> deleteTodo(Todo todo) async {
    _todoListState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      await _deleteTodoUseCase.deleteTodo(todo);
      await fetchTodoList();
    } catch (exception) {
      _todoListState = ResourceState.error(DefaultDeleteTodoError());
    }

    notifyListeners();
  }

  Future<void> fetchTodoList() async {
    List<Todo> todoList = await _getTodoListUseCase.getTodoList();
    _todoListState = ResourceState.success(todoList);
  }
}
