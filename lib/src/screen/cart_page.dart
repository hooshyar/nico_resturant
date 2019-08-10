import 'package:flutter/material.dart';
import 'package:nico_resturant/src/config/config.dart';
import 'package:nico_resturant/src/models/cart_model.dart';
import 'package:nico_resturant/src/services/cart.dart';
import 'package:nico_resturant/src/style/style.dart';
import 'package:nico_resturant/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartModel _theCart = Provider.of<CartModel>(context);
    return Container(
      child: Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: secondColor),
            backgroundColor: Colors.transparent,
            brightness: Brightness.light,
            elevation: 0,
            title: Text(
              'Cart',
              style: TextStyle(color: secondColor),
            ),
          ),
          body: Center(
            child: Container(
                child: _theCart.listOfCartItems.isEmpty
                    ? Container()
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20.0, right: 20, top: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child: Text('Item Name : ')),
                                  VerticalDivider(),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text('QTY : '),
                                    ),
                                  ),
                                  VerticalDivider(),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Price : ',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: ListView.builder(
                                    itemCount: _theCart.listOfCartItems.length,
                                    itemBuilder: (context, index) {
                                      CartItem _theItem =
                                          _theCart.listOfCartItems[index];
                                      return Container(
                                        alignment: Alignment.center,
                                        child: globalCard(
                                          margin: EdgeInsets.all(10),
                                          bgColor: secondColor,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                    child: Text(
                                                        _theItem.foodName)),
                                                VerticalDivider(),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(_theItem.itemQTY
                                                        .toString()),
                                                  ),
                                                ),
                                                VerticalDivider(),
                                                Expanded(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      _theItem.foodPrice
                                                              .toString() +
                                                          moneySign,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: secondColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(20),
                              height: 200,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                'total: ' +
                                                    _calculateTotal(_theCart)
                                                        .toString() +
                                                    moneySign,
                                                style: TextStyle(fontSize: 25),
                                              )),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          color: Colors.amber,
                                        )),
                                        VerticalDivider(),
                                        Expanded(
                                            child: Container(
                                          color: Colors.amber,
                                        )),
                                        VerticalDivider(),
                                        Expanded(
                                            child: Container(
                                          color: Colors.amber,
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
          )),
    );
  }

  _calculateTotal(CartModel cart) {
    num total = 0;
    cart.listOfCartItems.forEach((item) {
      total += item.foodPrice * item.itemQTY;
    });
    return total;
  }
}
