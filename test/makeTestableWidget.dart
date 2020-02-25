import 'package:flutter/material.dart';
import 'package:flutter_tinder/core/size_config.dart';
import 'package:flutter_tinder/dependency_locator.dart';
import 'package:flutter_tinder/providers/favorite_people_provider.dart';
import 'package:flutter_tinder/providers/people_provider.dart';
import 'package:provider/provider.dart';

Widget makeTestableWidget(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<PeopleProvider>(
          create: (_) => getIt<PeopleProvider>()),
      ChangeNotifierProvider<FavoritePeopleProvider>(
          create: (_) => getIt<FavoritePeopleProvider>()),
    ],
    child: MaterialApp(
      home: TestableWidget(child),
    ),
  );
}

class TestableWidget extends StatelessWidget {
  final Widget child;

  const TestableWidget(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return child;
  }
}
