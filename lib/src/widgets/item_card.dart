import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/food.dart';
import 'package:nico_resturant/src/widgets/cart_button.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({this.food, this.increment, this.decrement});

  final NicoFood food;
  final VoidCallback increment;
  final VoidCallback decrement;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  var _rating = 5.0;
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: new Card(
          elevation: 0.0,
          child: new Container(
            height: math.min(350.0, MediaQuery.of(context).size.height),
            child: new Container(
              padding: EdgeInsets.only(top: 100),
              margin: const EdgeInsets.only(top: 20.0, bottom: 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(widget.food.name,
                        style: const TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Dosis')),
                  ),
                  Expanded(
//                    height: 100,

                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 0),
                          child: SmoothStarRating(
                            onRatingChanged: null,
                            color: Colors.amber,
                            starCount: 5,
                            rating: _rating,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: new ClipRRect(
                        borderRadius: new BorderRadius.circular(50.0),
                        child: new MaterialButton(
                          minWidth: 70.0,
                          onPressed: null,
                          color: Colors.grey[900],
                          child: new Text(widget.food.price,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(Icons.remove),
                            onPressed: widget.food.quantity == 0
                                ? null
                                : widget.decrement,
                          ),
                          new Container(
                            decoration: new BoxDecoration(
                              border: new Border.all(
                                color: Colors.grey[700],
                                width: 0.5,
                              ),
                            ),
                            child: new SizedBox(
                              width: 70.0,
                              height: 45.0,
                              child: new Center(
                                  child: new Text('${widget.food.quantity}',
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                      textAlign: TextAlign.center)),
                            ),
                          ),
                          new IconButton(
                            icon: new Icon(Icons.add),
                            onPressed: widget.increment,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: CartButton(
                          counter: widget.food.quantity,
                          addToCart: () {
//
//                          onChangeNicoFoodItem(index, 0, food);
//                          playAnimation();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
