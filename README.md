# Network Bound Resource

Generic implementation of the network-bound-resource algorithm in Dart.

## Usage

You can add this library as a Git dependency to your project:

```yaml
dependencies:
  # ...
  nbr:
    git:
      url: git@github.com:sunderee/nbr.git
      ref: master
```

Your repository class should extend [NetworkBoundResource].

```dart
// For example ...
class MyRepositoryImpl extends NetworkBoundResource implements IMyRepository {}
```

Then, you can use the `run()` method which returns a stream of `Resource` objects. For example

```dart
Stream<Resource<MapEntry<String, List<String>>>> fetchPackageDependencies(
    String package,
) async* {
    yield* fetch<MapEntry<String, List<String>>, List<String>>(
        fetchFromAPI: () async => await _fetchDependencies(package),
        loadFromDB: () {
            final versions = _mockDB[package];
            return versions != null ? MapEntry(package, versions) : null;
        },
        storeToDB: (entry) => _persistDependencies(entry.key, entry.value),
        shouldFetch: (entry) => entry == null || !_mockDB.containsKey(package),
        mapDTOToEntity: (versions) => MapEntry(package, versions),
    );
}
```

## License

Project is open-sourced under the MIT license.
