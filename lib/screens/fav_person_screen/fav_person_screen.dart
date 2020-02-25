import 'package:flutter/material.dart';
import 'package:flutter_tinder/widgets/person_card.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tinder/providers/favorite_people_provider.dart';

class FavPersonScreen extends StatelessWidget {
  static const routeName = '/fav-person-screen';

  @override
  Widget build(BuildContext context) {
    final people =
        Provider.of<FavoritePeopleProvider>(context, listen: false).people;
    final picture = ModalRoute.of(context).settings.arguments as String;

    final person = people.firstWhere((p) => p.picture == picture);

    return Scaffold(
      appBar: AppBar(
        title: Text(person.fullName),
      ),
      body: Center(
        child: PersonCard(
          person: person,
        ),
      ),
    );
  }
}
