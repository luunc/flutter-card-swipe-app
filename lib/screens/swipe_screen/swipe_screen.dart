import 'package:flutter/material.dart';
import 'package:flutter_tinder/screens/favorite_screen/favorite_screen.dart';
import 'package:flutter_tinder/screens/swipe_screen/error_notification/error_notification.dart';
import 'package:flutter_tinder/screens/swipe_screen/middle_card/middle_card.dart';
import 'package:flutter_tinder/core/swipe_detection.dart';
import 'package:flutter_tinder/screens/swipe_screen/top_card/top_card.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tinder/core/size_config.dart';
import 'package:flutter_tinder/providers/people_provider.dart';

class SwipeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _removeController;
  Animation<Rect> _removeAnimation;

  Offset offset = Offset(0, 0);

  @override
  void initState() {
    super.initState();

    final peopleProvider = Provider.of<PeopleProvider>(context, listen: false);

    Future.microtask(() {
      peopleProvider.initData();
    });

    _removeController = AnimationController(
      duration: Duration(milliseconds: SwipeDetection.minAnimateOutTime),
      vsync: this,
    );

    _removeController.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        if (_removeAnimation.value.left != 0.0 &&
            _removeAnimation.value.top != 0.0) {
          var addToFav = false;
          if (_removeAnimation.value.left == SizeConfig.screenWidth * 1.5) {
            addToFav = true;
          }
          peopleProvider.popPerson(addToFav);
        }

        setState(() {
          offset = Offset(0, 0);
        });
        _removeController.reset();
      }
    });

    _removeAnimation = RectTween(
      begin: Rect.fromLTRB(0, 0, 0, 0),
      end: Rect.fromLTRB(0, 0, 0, 0),
    ).animate(_removeController);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildSwitchFakeData(),
                _buildButtonGoToFav(),
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
            Container(
              width: SizeConfig.cardWidth,
              height: SizeConfig.cardHeight,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  MiddleCard(
                    offset: offset,
                    removeAnimation: _removeAnimation,
                  ),
                  TopCard(
                    offset: offset,
                    removeAnimation: _removeAnimation,
                  ),
                  _buildSwipeController(),
                ],
              ),
            ),
            _buildErrorChecker(),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeController() {
    if (_removeController.status == AnimationStatus.forward) return Container();

    return Positioned.fill(
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          final newX = offset.dx + details.delta.dx;
          final newY = offset.dy + details.delta.dy;
          setState(() {
            offset = Offset(newX, newY);
          });
        },
        onPanEnd: (DragEndDetails details) {
          final SwipeDetectionResult result =
              SwipeDetection.getResultOnSwipeEnd(
                  offset: offset, details: details);

          _removeAnimation = RectTween(
            begin: Rect.fromLTRB(offset.dx, offset.dy, 0, 0),
            end: Rect.fromLTRB(result.x, result.y, 0, 0),
          ).animate(_removeController);

          _removeController.duration = result.duration;
          _removeController.forward();
          return;
        },
      ),
    );
  }

  Widget _buildErrorChecker() {
    return Selector<PeopleProvider, List>(
      selector: (_, provider) =>
          [provider.error, provider.checkForUpdatePeople],
      builder: (_, data, __) => ErrorNotification(data[0], data[1]),
    );
  }

  Widget _buildSwitchFakeData() {
    return Selector<PeopleProvider, List>(
      selector: (_, provider) =>
          [provider.useFakeData, provider.toggleUseFakeData],
      builder: (_, data, __) => Column(
        children: <Widget>[
          Text('Use fake data:', style: TextStyle(height: 1)),
          Switch(
            onChanged: data[1],
            value: data[0],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonGoToFav() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(FavoriteScreen.routeName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Go to Favorite', style: TextStyle(color: Colors.white)),
            Icon(Icons.keyboard_arrow_right, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
