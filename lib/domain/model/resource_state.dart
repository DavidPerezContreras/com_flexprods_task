class ResourceState<T> {
  T? data;
  Status status;
  Error? error;

  ResourceState.success(this.data) : status = Status.SUCCESS;
  ResourceState.loading() : status = Status.LOADING;
  ResourceState.error(Error e) : status = Status.ERROR;
  ResourceState.none() : status = Status.NONE;
}

enum Status { LOADING, SUCCESS, ERROR, NONE }
