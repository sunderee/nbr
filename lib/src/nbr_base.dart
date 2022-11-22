import 'dart:async';

import 'package:nbr/src/resource.dart';
import 'package:nbr/src/typedefs.dart';

abstract class NetworkBoundResource {
  Stream<Resource<Entity>> run<Entity, DTO>({
    required FetchFromApiCallback<DTO> fetchFromAPI,
    required LoadFromDBCallback<Entity> loadFromDB,
    required StoreToDBCallback<Entity> storeToDB,
    required ShouldFetchCallback<Entity> shouldFetch,
    required MapDTOToEntity<DTO, Entity> mapDTOToEntity,
  }) async* {
    yield* _emit(Resource.loading(null));
    final data = await loadFromDB();

    if (shouldFetch(data)) {
      yield* _emit(Resource.loading(data));
      try {
        final dto = await fetchFromAPI();
        final entity = mapDTOToEntity(dto);

        await storeToDB(entity);

        yield* _emit(Resource.success(entity));
      } on Exception catch (exception) {
        yield* _emit(Resource.failed(exception));
      }
    } else {
      if (data != null) {
        yield* _emit(Resource.success(data));
      } else {
        yield* _emit(Resource.empty());
      }
    }
  }

  Stream<T> _emit<T>(T data) => Stream.value(data);
}
