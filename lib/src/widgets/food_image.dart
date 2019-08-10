import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/food.dart';

class FoodImage extends StatelessWidget {
  FoodImage({this.food});
  final NicoItem food;

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: FractionalOffset.topCenter,
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: new Image(
          image: new AssetImage(food.image),
          height: 250.0,
          width: 250.0,
        ),
      ),
    );
  }
}
