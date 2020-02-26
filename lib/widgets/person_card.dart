import 'package:flutter/material.dart';
import 'package:flutter_tinder/core/size_config.dart';
import 'package:flutter_tinder/models/person.dart';
import 'package:flutter_tinder/widgets/bottom_card/bottom_card.dart';

class PersonCard extends StatelessWidget {
  final Person person;

  const PersonCard({Key key, @required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardWidth = SizeConfig.cardWidth;
    final cardHeight = SizeConfig.cardHeight;

    final String imgUrl = person?.picture ?? '';

    return Container(
      key: Key('widgets|person_card'),
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 200,
            offset: Offset(10, 10),
          ),
        ],
      ),
      child: Column(children: <Widget>[
        _buildUpperPart(),
        Expanded(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              BottomCard(
                person,
                key: imgUrl == null ? null : Key(imgUrl),
              ),
              _buildAvatar(imgUrl),
            ],
          ),
        ),
      ]),
    );
  }

  _buildUpperPart() {
    return Container(
      height: SizeConfig.cardSizeVertical * 40,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  _buildAvatar(String imgUrl) {
    final diameter = SizeConfig.cardSizeHorizontal * 70;

    return Positioned(
      top: -SizeConfig.cardSizeVertical * 25,
      left: SizeConfig.cardSizeHorizontal * 15,
      child: Container(
        padding: EdgeInsets.all(5),
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: imgUrl.isEmpty
            ? Center(child: CircularProgressIndicator())
            : CircleAvatar(
                key: Key(imgUrl),
                backgroundImage: NetworkImage(imgUrl),
              ),
      ),
    );
  }
}
