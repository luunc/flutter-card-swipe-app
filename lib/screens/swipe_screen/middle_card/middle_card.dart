import 'package:flutter/material.dart';
import 'package:flutter_tinder/core/size_config.dart';
import 'package:flutter_tinder/providers/people_provider.dart';
import 'package:provider/provider.dart';

class MiddleCard extends StatelessWidget {
  static const defaultScaleFactor = 0.75;

  final Offset offset;
  final Animation<Rect> removeAnimation;

  const MiddleCard({
    Key key,
    @required this.removeAnimation,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: removeAnimation,
      builder: (_, child) {
        double addScaleFactor = offset.dx.abs() / SizeConfig.screenWidth / 2.5;

        if (removeAnimation.status == AnimationStatus.forward) {
          final x = removeAnimation.value.left.abs();
          addScaleFactor = x / SizeConfig.screenWidth / 2.5;
        }

        if (addScaleFactor > 1 - defaultScaleFactor)
          addScaleFactor = 1 - defaultScaleFactor;

        return Transform.scale(
          scale: defaultScaleFactor + addScaleFactor,
          child: child,
        );
      },
      child: Selector<PeopleProvider, Widget>(
        selector: (_, provider) => provider.cards[1],
        builder: (_, widget, __) => widget,
      ),
    );
  }
}
