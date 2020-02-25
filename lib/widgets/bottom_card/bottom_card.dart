import 'package:flutter/material.dart';
import 'package:flutter_tinder/core/size_config.dart';
import 'package:flutter_tinder/models/location.dart';

import '../../models/person.dart';

class BottomCard extends StatefulWidget {
  final Person person;

  const BottomCard(this.person, {Key key}) : super(key: key);

  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  static const icons = [
    Icons.person,
    Icons.calendar_today,
    Icons.location_on,
    Icons.phone,
    Icons.lock,
  ];

  int currentTab = 0;
  List<Widget> allTabs = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> allTabs = [
      _buildUserInfo(),
      _buildCalendar(),
      _buildAddress(),
      _buildPhoneNumber(),
      _buildPassword(),
    ];

    return Container(
      height: SizeConfig.cardSizeVertical * 60,
      padding: EdgeInsets.only(
        top: SizeConfig.cardSizeVertical * 25,
        left: SizeConfig.cardSizeHorizontal * 2,
        right: SizeConfig.cardSizeHorizontal * 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: SizeConfig.cardSizeVertical * 20,
            child: allTabs[currentTab],
          ),
          Container(
            child: _buildBottomTabIcons(),
            height: SizeConfig.cardSizeVertical * 15,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    final String name = widget.person?.fullName ?? '';
    final String gender = widget.person?.gender ?? '';
    final String email = widget.person?.email ?? '';

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: SizeConfig.cardSizeHorizontal * 7,
            ),
          ),
          Text(
            email,
            style: TextStyle(
              fontSize: SizeConfig.cardSizeHorizontal * 5,
              color: Colors.grey,
            ),
          ),
          Text(
            gender,
            style: TextStyle(
              fontSize: SizeConfig.cardSizeHorizontal * 4,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container();
  }

  Widget _buildAddress() {
    final Location location = widget.person?.location ?? null;
    final String street = location?.street ?? '';
    final String city = location?.city ?? '';
    final String state = location?.state ?? '';

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            street,
            style: TextStyle(
              fontSize: SizeConfig.cardSizeHorizontal * 7,
            ),
          ),
          Text(
            city,
            style: TextStyle(
              fontSize: SizeConfig.cardSizeHorizontal * 5,
              color: Colors.grey,
            ),
          ),
          Text(
            state,
            style: TextStyle(
              fontSize: SizeConfig.cardSizeHorizontal * 4,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Container();
  }

  Widget _buildPassword() {
    return Container();
  }

  Widget _buildBottomTabIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ...icons
            .asMap()
            .map((i, icon) => MapEntry(
                  i,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = i;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.all(SizeConfig.cardSizeHorizontal * 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentTab == i ? Colors.greenAccent : null,
                      ),
                      child: Icon(
                        icon,
                        size: SizeConfig.cardSizeHorizontal * 8,
                        color:
                            currentTab == i ? Colors.white : Colors.grey[500],
                      ),
                    ),
                  ),
                ))
            .values
            .toList()
      ],
    );
  }
}
