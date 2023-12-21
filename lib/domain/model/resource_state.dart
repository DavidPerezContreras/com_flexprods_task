class ResourceState<T> {
  T? data;
  Status status;
  Error? error;

  ResourceState.success(this.data) : status = Status.SUCCESS;
  ResourceState.loading() : status = Status.LOADING;
  ResourceState.error() : status = Status.ERROR;
}

enum Status { LOADING, SUCCESS, ERROR }
