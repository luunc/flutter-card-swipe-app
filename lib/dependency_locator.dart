import 'package:dio/dio.dart';
import 'package:flutter_tinder/core/sqflite/db_helper.dart';
import 'package:get_it/get_it.dart';

import 'providers/people_provider.dart';
import 'providers/favorite_people_provider.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependency() async {
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<PeopleProvider>(PeopleProvider(getIt<Dio>()));

  getIt.registerSingleton<DBHelper>(DBHelper());

  getIt.registerSingleton<FavoritePeopleProvider>(
      FavoritePeopleProvider(getIt<DBHelper>()));
}
