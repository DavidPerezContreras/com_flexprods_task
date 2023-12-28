import 'describable_error.dart';

class ResourceState<T> {
  T? data;
  Status status;
  DescribableError? error;

  ResourceState.success(this.data) : status = Status.SUCCESS;

  ResourceState.loading() : status = Status.LOADING;

  ResourceState.error(this.error) : status = Status.ERROR;

  ResourceState.none() : status = Status.NONE;
}

enum Status { LOADING, SUCCESS, ERROR, NONE }
