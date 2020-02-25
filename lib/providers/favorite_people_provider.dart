import 'package:flutter/foundation.dart';
import 'package:flutter_tinder/core/sqflite/db_helper.dart';
import 'package:flutter_tinder/models/person.dart';

class FavoritePeopleProvider with ChangeNotifier {
  final DBHelper dbHelper;

  FavoritePeopleProvider(this.dbHelper);

  bool fetched = false;
  List<Person> _people = [];

  List<Person> get people => _people;

  Future<bool> addFav(Person person) async {
    if (person == null) return false;
    if (_people.indexWhere((p) => person.picture == p.picture) > -1)
      return true;

    _people.add(person);

    await dbHelper.insert(person.toJson());
    return true;
  }

  Future<void> getData() async {
    if (fetched) return;
    List<Map<String, dynamic>> data = await dbHelper.get();

    List<Person> newPeople = data.map((json) {
      return Person.fromJson(json);
    }).toList();

    newPeople = newPeople
        .where((nP) => _people.indexWhere((p) => nP.picture == p.picture) < 0)
        .toList();

    _people.addAll(newPeople);

    fetched = true;
    notifyListeners();
  }

  Future<void> delete(String picture) async {
    await dbHelper.delete(picture);
    _people.removeWhere((person) => person.picture == picture);
    notifyListeners();
  }
}
