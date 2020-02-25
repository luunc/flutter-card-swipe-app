import 'package:flutter/material.dart';
import 'package:flutter_tinder/screens/fav_person_screen/fav_person_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tinder/core/size_config.dart';
import 'package:flutter_tinder/providers/favorite_people_provider.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite-screen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FavoritePeopleProvider>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final provider = Provider.of<FavoritePeopleProvider>(context);
    final people = provider.people;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          final person = people[i];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(FavPersonScreen.routeName,
                  arguments: person.picture);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    )
                  ]),
              child: ListTile(
                leading: CircleAvatar(
                  key: Key(person.picture),
                  backgroundImage: NetworkImage(person.picture),
                ),
                title: Text(person.fullName),
                subtitle: Text(person.email),
                trailing: GestureDetector(
                  onTap: () {
                    provider.delete(person.picture);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: people.length,
      ),
    );
  }
}
