import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_tinder/core/size_config.dart';

class SwipeDetectionResult {
  final double x;
  final double y;
  final Duration duration;

  SwipeDetectionResult._({
    @required this.x,
    @required this.y,
    @required this.duration,
  });
}

class SwipeDetection {
  static const minAnimateOutTime = 200; // milli second;

  static getResultOnSwipeEnd({
    @required Offset offset,
    @required DragEndDetails details,
  }) {
    final x = offset.dx;
    final y = offset.dy;
    final velocityX = details.velocity.pixelsPerSecond.dx;
    final velocityY = details.velocity.pixelsPerSecond.dy;
    final velocity = math.sqrt(velocityX * velocityX + velocityY * velocityY);
    final tanVelocity = velocityY != 0 ? velocityX / velocityY : 0;

    if (x < -SizeConfig.screenWidth / 1.5 || velocityX < -250) {
      // Case: velocity == 0
      final animateX = -SizeConfig.screenWidth * 1.5;
      var animateY = y < 0 ? -SizeConfig.screenHeight : SizeConfig.screenHeight;
      var animateTime = minAnimateOutTime;

      if (velocity != 0) {
        animateY = tanVelocity != 0 ? animateX / tanVelocity : 0;
        final delta = math.sqrt(animateX * animateX + animateY * animateY);
        final measureTime = (delta / velocity * 1000).toInt();
        if (measureTime < minAnimateOutTime) animateTime = measureTime;
      }

      return SwipeDetectionResult._(
        x: animateX,
        y: animateY,
        duration: Duration(milliseconds: animateTime),
      );
    }

    if (x > SizeConfig.screenWidth / 1.5 || velocityX > 250) {
      // Case: velocity == 0
      final animateX = SizeConfig.screenWidth * 1.5;
      var animateY = y < 0 ? -SizeConfig.screenHeight : SizeConfig.screenHeight;
      var animateTime = minAnimateOutTime;

      if (velocity != 0) {
        animateY = tanVelocity != 0 ? animateX / tanVelocity : 0;
        final delta = math.sqrt(animateX * animateX + animateY * animateY);
        final measureTime = (delta / velocity * 1000).toInt();
        if (measureTime < minAnimateOutTime) animateTime = measureTime;
      }

      return SwipeDetectionResult._(
        x: animateX,
        y: animateY,
        duration: Duration(milliseconds: animateTime),
      );
    }

    return SwipeDetectionResult._(
      x: 0.0,
      y: 0.0,
      duration: Duration(milliseconds: minAnimateOutTime),
    );
  }
}
