import 'package:flutter/material.dart';
import 'package:flutter_tinder/providers/people_provider.dart';
import 'package:flutter_tinder/widgets/person_card.dart';
import 'package:provider/provider.dart';

class BackCard extends StatelessWidget {
  final AnimationController removeController;

  const BackCard({
    Key key,
    @required this.removeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
//        alignment: animationController.status == AnimationStatus.forward
//            ? CardsAnimation.frontCardDisappearAlignmentAnim(
//            animationController, frontCardAlign)
//            .value
//            : frontCardAlign,
        child: Selector<PeopleProvider, Widget>(
      selector: (_, provider) => provider.cards[2],
      builder: (_, widget, __) => widget,
    )

//        Transform.rotate(
//          angle: (pi / 180.0) * frontCardRot,
//          child: SizedBox.fromSize(size: cardsSize[0], child: cards[0]),
//        )
        );
  }
}
