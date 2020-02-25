import 'dart:convert';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

const TINDER_CARDS = 'TINDER_CARDS5';

class DBHelper {
  Future<sql.Database> _openDatabase() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, '$TINDER_CARDS.db'),
      onCreate: (sql.Database db, int version) {
        return db.execute('''
              CREATE TABLE People(
                  gender TEXT,
                  email TEXT,
                  dob TEXT,
                  picture TEXT PRIMARY KEY,
                  name TEXT,
                  location TEXT
              );
         ''');
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> get({offset = 0, limit = 10}) async {
    try {
      final db = await _openDatabase();
      final rawData = await db.query('People');

      final data = rawData.map((person) {
        final p = Map<String, dynamic>.from(person);
        p['name'] = jsonDecode(p['name']);
        p['location'] = jsonDecode(p['location']);
        return p;
      }).toList();

      return data;
    } catch (e) {}
  }

  Future<void> insert(Map<String, dynamic> data) async {
    try {
      final db = await _openDatabase();

      data['name'] = jsonEncode(data['name']);
      data['location'] = jsonEncode(data['location']);

      await db.insert('People', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (e) {}
  }

  Future<void> delete(String picture) async {
    final db = await _openDatabase();
    await db.delete('People', where: 'picture = ?', whereArgs: [picture]);
  }
}
