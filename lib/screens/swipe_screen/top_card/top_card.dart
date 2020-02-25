import 'package:flutter/material.dart';
import 'package:flutter_tinder/providers/people_provider.dart';
import 'package:provider/provider.dart';

class TopCard extends StatelessWidget {
  final Offset offset;
  final Animation<Rect> removeAnimation;

  const TopCard({
    Key key,
    @required this.removeAnimation,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: removeAnimation,
      builder: (_, child) {
        var left = offset.dx;
        var top = offset.dy;

        if (removeAnimation.status == AnimationStatus.forward) {
          left = removeAnimation.value.left;
          top = removeAnimation.value.top;
        }

        return Positioned(
          top: top,
          left: left,
          child: Transform.rotate(
            angle: left / 840,
            child: child,
          ),
        );
      },
      child: Selector<PeopleProvider, Widget>(
        selector: (_, provider) => provider.cards[0],
        builder: (_, widget, __) => widget,
      ),
    );
  }
}
