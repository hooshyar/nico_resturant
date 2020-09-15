import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:nico_resturant/src/config/config.dart';
import 'package:nico_resturant/src/models/cart_model.dart';
import 'package:nico_resturant/src/models/food.dart';
import 'package:nico_resturant/src/services/cart.dart';
import 'package:nico_resturant/src/widgets/cart_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemCardGrid extends StatefulWidget {
  const ItemCardGrid({this.food});

  final NicoItem food;

  @override
  _ItemCardGridState createState() => _ItemCardGridState();
}

class _ItemCardGridState extends State<ItemCardGrid> {
  var _rating = 5.0;
  int _quanity = 0;
  @override
  Widget build(BuildContext context) {
    CartModel _item = Provider.of<CartModel>(context);
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: new Card(
          elevation: 0.0,
          child: new Container(
            height: math.min(400.0, MediaQuery.of(context).size.height),
            child: new Container(
              padding: EdgeInsets.only(top: 90),
              margin: const EdgeInsets.only(top: 30.0, bottom: 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(widget.food.name,
                          style: const TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Dosis')),
                    ),
                  ),
                  Expanded(
//                    height: 100,

                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 0),
                          child: AbsorbPointer(
                            child: SmoothStarRating(
                              onRatingChanged: null,
                              color: Colors.amber,
                              starCount: 5,
                              rating: widget.food.stars,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  // Expanded(
                  //   child: new DecoratedBox(
                  //     decoration: new BoxDecoration(
                  //         borderRadius: new BorderRadius.circular(30.0)),
                  //     child: new ClipRRect(
                  //       borderRadius: new BorderRadius.circular(50.0),
                  //       child: new MaterialButton(
                  //         minWidth: 70.0,
                  //         onPressed: null,
                  //         color: Colors.grey[900],
                  //         child: new Text(
                  //             widget.food.price.toString() + ' $moneySign',
                  //             style: const TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 17.0,
                  //                 fontWeight: FontWeight.w500)),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new IconButton(
                              icon: new Icon(Icons.remove),
                              onPressed: () {
                                _quanity == 0
                                    ? null
                                    : setState(() {
                                        _quanity--;
                                      });
                              }),
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
                                  child: new Text('${_quanity}',
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                      textAlign: TextAlign.center)),
                            ),
                          ),
                          new IconButton(
                              icon: new Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _quanity++;
                                });
                              }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
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
                                child: new Text(
                                    widget.food.price.toString() +
                                        ' $moneySign',
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
                            padding: EdgeInsets.only(top: 10),
                            child: CartButton(
                                counter: _quanity,
                                addToCart: () {
                                  Provider.of<CartModel>(context)
                                      .listKey
                                      .currentState
                                      .insertItem(_item.listOfCartItems.length);

                                  _item.listOfCartItems.add(CartItem(
                                      foodName: widget.food.name,
                                      itemImage: widget.food.image,
                                      foodPrice: widget.food.price,
                                      itemQTY: _quanity,
                                      itemId: widget.food.id));

                                  _item.notifyListeners();

//                            debugPrint('list of cart items length is : ' +
//                                _item.listOfCartItems.length.toString());
//                            debugPrint('Cart zero item qty is : ' +
//                                _item.listOfCartItems[0].itemQTY.toString());
//                            debugPrint(
//                                'second item food name is : ${_item.listOfCartItems[1].foodName} and price '
//                                'is:${_item.listOfCartItems[1].foodPrice}');
                                }),
                          ),
                        ),
                      ],
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
