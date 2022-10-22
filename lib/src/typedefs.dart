import 'dart:async';

typedef FetchFromApiCallback<DTO> = FutureOr<DTO> Function();
typedef LoadFromDBCallback<Entity> = FutureOr<Entity?> Function();
typedef StoreToDBCallback<Entity> = FutureOr<void> Function(Entity data);
typedef ShouldFetchCallback<Entity> = bool Function(Entity? entity);
typedef MapDTOToEntity<DTO, Entity> = Entity Function(DTO dto);
