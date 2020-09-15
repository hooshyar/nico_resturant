import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/food.dart';
import 'package:nico_resturant/src/widgets/food_image.dart';
import 'package:nico_resturant/src/widgets/item_card_grid.dart';
import 'package:nico_resturant/src/widgets/shadows.dart';

class ItemRouter extends StatelessWidget {
  final NicoItem food;
  final int index;
  final Alignment alignment;
  final double resize;

  const ItemRouter(
      {Key key, this.food, this.index, this.alignment, this.resize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 0),
                alignment: alignment,
                // width: 170.0 * resize,
                // height: 170.0 * resize,
                child: Stack(
                  children: <Widget>[
                    shadow2,
                    shadow1,
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 50, left: 35, right: 10),
                          child: ItemCardGrid(
                            food: food,

//                              onChangeNicoItemItem(index, _counter, food);
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 0),
                      child: FoodImage(
                        imageAlign: FractionalOffset.topCenter,
                        food: food,
                        height: 180,
                        width: 180,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
