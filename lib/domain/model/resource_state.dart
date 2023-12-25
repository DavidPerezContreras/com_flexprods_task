import 'package:nested_navigation/data/auth/remote/error/auth_errors.dart';

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
