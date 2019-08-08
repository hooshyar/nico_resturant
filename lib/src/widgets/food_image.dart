import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/food.dart';

class FoodImage extends StatelessWidget {
  FoodImage({this.food});
  final NicoFood food;

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: FractionalOffset.topCenter,
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
//        onTap: () =>
//            Routes.navigateTo(
//              context,
//              '/detail/${food.id}',
//            ),
        child: new Hero(
          tag: 'icon-${food.id}',
          child: new Image(
            image: new AssetImage(food.image),
            height: 250.0,
            width: 250.0,
          ),
        ),
      ),
    );
  }
}
