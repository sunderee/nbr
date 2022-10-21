import 'package:meta/meta.dart';

@sealed
abstract class Resource<T> {
  @internal
  final T? baseData;

  @internal
  final Exception? baseException;

  @internal
  @literal
  const Resource(this.baseData, this.baseException);

  @protected
  const factory Resource.empty() = Empty;

  @protected
  const factory Resource.loading(T? data) = Loading;

  @protected
  const factory Resource.success(T data) = Success;

  @protected
  const factory Resource.failed(Exception exception, T? data) = Failed;
}

class Empty<T> extends Resource<T> {
  const Empty() : super(null, null);
}

class Loading<T> extends Resource<T> {
  final T? data;

  const Loading(this.data) : super(data, null);
}

class Success<T> extends Resource<T> {
  final T data;

  const Success(this.data) : super(data, null);
}

class Failed<T> extends Resource<T> {
  final Exception exception;
  final T? data;

  const Failed(this.exception, this.data) : super(data, exception);
}
