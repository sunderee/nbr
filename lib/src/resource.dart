import 'package:meta/meta.dart';

/// Wrapper around the result (empty/loading/successful/failed) returned by the
/// network-bound resource algorithm.
@sealed
abstract class Resource<T> {
  /// Data contained by the resource. It can be null.
  @internal
  final T? baseData;

  /// Exception which might be thrown in case of a failure.
  @internal
  final Exception? baseException;

  /// Default constructor.
  @internal
  @literal
  const Resource(this.baseData, this.baseException);

  /// Construct the [Empty] concrete class.
  @protected
  const factory Resource.empty() = Empty;

  /// Construct the [Loading] concrete class with nullable [data].
  @protected
  const factory Resource.loading(T? data) = Loading;

  /// Construct the [Success] concrete class with [data].
  @protected
  const factory Resource.success(T data) = Success;

  /// Construct the [Failed] concrete class with [exception].
  @protected
  const factory Resource.failed(Exception exception) = Failed;
}

/// [Empty] is a concrete class that extends [Resource] and represents an empty
/// resource. It has no additional fields and has a default constructor that
/// calls the super constructor with null values for [baseData] and
/// [baseException].
class Empty<T> extends Resource<T> {
  const Empty() : super(null, null);
}

/// [Loading] is a concrete class that extends [Resource] and represents a
/// resource that is currently being loaded. It has one field, [data], which
/// represents the data that is being loaded. It has a constructor that takes an
/// argument [data] and passes it to the super constructor along with `null` for
/// [baseException].
class Loading<T> extends Resource<T> {
  final T? data;

  const Loading(this.data) : super(data, null);
}

/// [Success] is a concrete class that extends [Resource] and represents a
/// successful resource. It has one field, [data], which represents the data of
/// the resource. It has a constructor that takes an argument [data] and passes
/// it to the super constructor along with `null` for [baseException].
class Success<T> extends Resource<T> {
  final T data;

  const Success(this.data) : super(data, null);
}

/// [Failed] is a concrete class that extends [Resource] and represents a
/// resource that has failed to load. It has one field, [exception], which
/// represents the exception that was thrown when the resource failed to load.
/// It has a constructor that takes an argument [exception] and passes it to the
/// super constructor along with `null` for [baseData].
class Failed<T> extends Resource<T> {
  final Exception exception;

  const Failed(this.exception) : super(null, exception);
}
