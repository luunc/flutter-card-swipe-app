import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;

  static double screenWidth;
  static double screenHeight;

  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double blockSizeVerticalNoToolBar;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static double cardHeight;
  static double cardWidth;

  static double cardSizeHorizontal;
  static double cardSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    final ratio = 10 / 17;
    cardWidth = blockSizeHorizontal * 90;

    cardHeight = cardWidth / ratio;
    if (cardHeight > blockSizeVertical * 70) {
      cardHeight = blockSizeVertical * 70;
    }

    cardSizeHorizontal = cardWidth / 100;
    cardSizeVertical = cardHeight / 100;

    blockSizeVerticalNoToolBar = (screenHeight - kToolbarHeight) / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
