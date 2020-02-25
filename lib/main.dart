import 'package:flutter/material.dart';
import 'package:flutter_tinder/dependency_locator.dart';
import 'package:flutter_tinder/screens/fav_person_screen/fav_person_screen.dart';
import 'package:flutter_tinder/screens/favorite_screen/favorite_screen.dart';
import 'package:flutter_tinder/screens/swipe_screen/swipe_screen.dart';
import 'package:provider/provider.dart';

import 'providers/favorite_people_provider.dart';
import 'providers/people_provider.dart';

void main() async {
  await initDependency();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PeopleProvider>(
            create: (_) => getIt<PeopleProvider>()),
        ChangeNotifierProvider<FavoritePeopleProvider>(
            create: (_) => getIt<FavoritePeopleProvider>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (_) => SwipeScreen(),
          FavoriteScreen.routeName: (_) => FavoriteScreen(),
          FavPersonScreen.routeName: (_) => FavPersonScreen(),
        },
      ),
    );
  }
}
