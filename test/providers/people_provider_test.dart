import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tinder/providers/people_provider.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio dio;
  PeopleProvider peopleProvider;

  setUp(() {
    dio = MockDio();
    peopleProvider = PeopleProvider(dio);
  });

  test('#1 first create with correct data', () {
    expect(peopleProvider.error, null);
    expect(peopleProvider.people, []);
  });

  group('#2 initData()', () {
    test('#2.1 initData success', () async {});

    test('#2.2 initData fail', () async {
      when(dio.get(any)).thenThrow(Exception());

      await peopleProvider.initData();

      expect(peopleProvider.error, isNotNull);
      expect(peopleProvider.people.length, 0);
    });
  });
}
