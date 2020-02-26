import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tinder/core/fixture/fixture_reader.dart';
import 'package:flutter_tinder/models/person.dart';
import 'package:flutter_tinder/providers/favorite_people_provider.dart';
import 'package:flutter_tinder/widgets/person_card.dart';

import '../dependency_locator.dart';

class PeopleProvider with ChangeNotifier {
  static const noOfPeopleToFetch = 5;
  static const noOfPeopleNeedToFetch = 2;

  ////////////////////////
  final Dio dio;

  PeopleProvider(this.dio);

  ////////////////////////
  List<Person> _people = [];

  List<Person> get people => _people;

  Exception _error;

  Exception get error => _error;

  bool _loading = false;

  bool get loading => _loading;

  bool _useFakeData = false;

  bool get useFakeData => _useFakeData;

  List<PersonCard> cards = [PersonCard(person: null), PersonCard(person: null)];

  void toggleUseFakeData(bool on) {
    _useFakeData = on;
    notifyListeners();

    if (on) {
      checkForUpdatePeople();
    }
  }

  Future<void> initData() async {
    try {
      _loading = true;
      if (_error != null) _error = null;
      notifyListeners();

      Object response;
      Map<String, dynamic> data;

      if (!_useFakeData) {
        response = await dio.get(
            'https://randomuser.me/api/0.4/?randomapi&results=$noOfPeopleToFetch');
        data = jsonDecode((response as Response).data);
      } else {
        response = await fixture('people.json');
        data = jsonDecode(response);
      }

      List users = data['results'];

      List<Person> initPeople = users.map((personMap) {
        Map<String, dynamic> json = personMap['user'];
        return Person.fromJson(json);
      }).toList();

      List<Person> rest = [];
      List<Person> uses = initPeople;
      if (initPeople.length > 2) {
        uses = initPeople.sublist(0, 2);
        rest = initPeople.sublist(2);
      }

      uses.asMap().forEach((index, person) {
        cards[index] = PersonCard(person: uses[index]);
      });

      _people = rest;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _checkForNotifyError(e);
    }
  }

  void _checkForNotifyError(Exception e) {
    _loading = false;
    if (_people.isNotEmpty) return;
    _error = e;
    notifyListeners();
  }

  Future<bool> popPerson(bool addFav) async {
    final popCard = cards[0];

    cards[0] = cards[1];
    cards[1] = PersonCard(person: _people.isEmpty ? null : _people.removeAt(0));

    notifyListeners();

    checkForUpdatePeople();
    if (addFav)
      return await getIt<FavoritePeopleProvider>().addFav(popCard.person);
    return false;
  }

  Future<void> checkForUpdatePeople() async {
    if (_loading || _people.length > noOfPeopleNeedToFetch) return;

    try {
      _loading = true;
      if (_error != null) _error = null;
      notifyListeners();

      Object response;
      Map<String, dynamic> data;

      if (!_useFakeData) {
        response = await dio.get(
            'https://randomuser.me/api/0.4/?randomapi&results=$noOfPeopleToFetch');
        data = jsonDecode((response as Response).data);
      } else {
        response = await fixture('people.json');
        data = jsonDecode(response);
      }

      List users = data['results'];

      List<Person> newPeople = users.map((personMap) {
        Map<String, dynamic> json = personMap['user'];
        return Person.fromJson(json);
      }).toList();

      cards.asMap().forEach((index, personCard) {
        if (personCard.person == null) {
          cards[index] = PersonCard(person: newPeople.removeLast());
        }
      });

      _people.addAll(newPeople);
      _loading = false;
      notifyListeners();
    } catch (e) {
      _checkForNotifyError(e);
    }
  }
}
