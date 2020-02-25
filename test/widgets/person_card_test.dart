import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/core/size_config.dart';
import 'package:flutter_tinder/dependency_locator.dart';
import 'package:flutter_tinder/models/location.dart';
import 'package:flutter_tinder/models/name.dart';
import 'package:flutter_tinder/models/person.dart';
import 'package:flutter_tinder/widgets/person_card.dart';

import '../makeTestableWidget.dart';

final aPerson = Person(
    dob: 'asdasd',
    email: 'saasd@gmail.com',
    gender: 'asdasdasd',
    picture:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTFXPNJQDazvgkfhvw_7zxCDVKeCc1C1i5EnfuLNe3mGRLXAPSf',
    location: Location(
        city: 'asdasd', state: 'asdasd', street: 'scasd', zip: 'asdasd'),
    name: Name(first: 'xxx', last: 'asdasd', title: 'asdasd'));

void main() async {
  setUpAll(
      () => HttpOverrides.global = null); // Need this for Image.Network to work

  await initDependency();

  testWidgets('#1 loading', (WidgetTester tester) async {
    HttpOverrides.runZoned(() async {
      Widget personCard = PersonCard(person: aPerson);
      final widget = makeTestableWidget(personCard);

      await tester.pumpWidget(widget);

      Finder wrapper = find.byKey(Key('widgets|person_card'));
      expect(wrapper, findsOneWidget);

      Finder avatar = find.byType(CircleAvatar);
      expect(avatar, findsOneWidget);

      Finder loading = find.byType(CircularProgressIndicator);
      expect(loading, findsNothing);
    });
  });

  testWidgets('#2 loaded', (WidgetTester tester) async {
    HttpOverrides.runZoned(() async {
      Widget personCard = PersonCard(person: null);
      final widget = makeTestableWidget(personCard);

      await tester.pumpWidget(widget);

      Finder wrapper = find.byKey(Key('widgets|person_card'));
      expect(wrapper, findsOneWidget);

      Finder avatar = find.byType(CircleAvatar);
      expect(avatar, findsNothing);

      Finder loading = find.byType(CircularProgressIndicator);
      expect(loading, findsOneWidget);
    });
  });
}
