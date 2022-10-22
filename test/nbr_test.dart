import 'package:nbr/nbr.dart';
import 'package:test/test.dart';

class SampleRepository extends NetworkBoundResource {
  final Set<int> _mockStore = {};

  Future<Resource<int>> mockRepositoryMethod() async {
    return run<int, String>(
      fetchFromAPI: () =>
          Future.delayed(Duration(milliseconds: 230), () => '42'),
      loadFromDB: () => _mockStore.first,
      storeToDB: (int value) async {
        _mockStore.add(value);
      },
      shouldFetch: (int? value) => value == null,
      mapDTOToEntity: (String value) => int.tryParse(value) ?? 0,
    ).first;
  }

  Stream<Resource<int>> mockRepositoryMethod2() async* {
    yield* run<int, String>(
      fetchFromAPI: () =>
          Future.delayed(Duration(milliseconds: 230), () => '42'),
      loadFromDB: () => _mockStore.first,
      storeToDB: (int value) async {
        _mockStore.add(value);
      },
      shouldFetch: (int? value) => true,
      mapDTOToEntity: (String value) => int.tryParse(value) ?? 0,
    );
  }
}

void main() {
  group('NetworkBoundResource', () {
    final repository = SampleRepository();

    test('should return value', () async {
      final result = await repository.mockRepositoryMethod();
      print('Result from repository: $result');
      expect(result, 42);
    });

    test('should emit correctly', () async {
      final events = await repository.mockRepositoryMethod2().toList();
      print('Events from repository: $events');

      expect(events, [Resource.loading(null), Resource.success(42)]);
    });
  });
}
