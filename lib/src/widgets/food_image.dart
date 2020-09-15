import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/food.dart';

class FoodImage extends StatelessWidget {
  FoodImage({this.food, this.height, this.width, this.imageAlign});
  final NicoItem food;
  final double height;
  final double width;
  final Alignment imageAlign;

  @override
  Widget build(BuildContext context) {
    return new Align(
      // alignment: FractionalOffset.topCenter,
      alignment: imageAlign,
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: new Image(
          image: new AssetImage(food.image),
          height: height,
          width: width,
        ),
      ),
    );
  }
}
