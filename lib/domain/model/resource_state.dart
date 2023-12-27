// ignore_for_file: constant_identifier_names

import 'package:nested_navigation/data/auth/remote/error/login_errors.dart';

import 'descriptable_error.dart';

class ResourceState<T> {
  T? data;
  Status status;
  DescriptableError? error;

  ResourceState.success(this.data) : status = Status.SUCCESS;
  ResourceState.loading() : status = Status.LOADING;
  ResourceState.error(this.error) : status = Status.ERROR;
  ResourceState.none() : status = Status.NONE;
}

enum Status { LOADING, SUCCESS, ERROR, NONE }
