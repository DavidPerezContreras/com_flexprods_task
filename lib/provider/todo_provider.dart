import 'package:flutter/material.dart';
import 'package:nested_navigation/data/todo/remote/error/todo_errors.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/usecase/todo/get_todo_list_usecase.dart';

class TodoProvider extends ChangeNotifier {
  late ResourceState<List<Todo>> _todoListState;
  late GetTodoListUseCase _getTodoListUseCase = GetTodoListUseCase();

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
    //await Future.delayed(const Duration(seconds: 1));

    try {
      List<Todo> todoList = await _getTodoListUseCase.getTodoList();
      _todoListState = ResourceState.success(todoList);
    } catch (exception) {
      _todoListState = ResourceState.error(DefaultGetTodoListError());
    }

    notifyListeners();
  }

  Future<void> createTodo() async {
    _todoListState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      List<Todo> todoList = await _getTodoListUseCase.getTodoList();
      _todoListState = ResourceState.success(todoList);
    } catch (exception) {
      _todoListState = ResourceState.error(DefaultGetTodoListError());
    }

    notifyListeners();
  }

  Future<void> updateTodo() async {
    _todoListState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      List<Todo> todoList = await _getTodoListUseCase.getTodoList();
      _todoListState = ResourceState.success(todoList);
    } catch (exception) {
      _todoListState = ResourceState.error(DefaultGetTodoListError());
    }

    notifyListeners();
  }

  Future<void> deleteTodo() async {
    _todoListState = ResourceState.loading();
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 1));

    try {
      List<Todo> todoList = await _getTodoListUseCase.getTodoList();
      _todoListState = ResourceState.success(todoList);
    } catch (exception) {
      _todoListState = ResourceState.error(DefaultGetTodoListError());
    }

    notifyListeners();
  }

}







