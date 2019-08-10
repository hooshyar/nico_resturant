import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/cart_model.dart';

class CartModel extends ChangeNotifier {
  ///internal private state of the Loading
  @override
  int _quanity = 0;
  int get quanity => _quanity;

  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  Cart _theCart;
  Cart get theCart => _theCart;
//
  CartItem _cartItem;
  CartItem get cartItem => _cartItem;
//
  var listOfCartItems = [];

  void addItemToCart(CartItem item) {
//    var index = listOfCartItems.length + 1;
    listOfCartItems[0] = item;
  }

  void makeItZer() {
    debugPrint(_quanity.toString());
    _quanity = 0;
    notifyListeners();
  }

  void increment() {
    debugPrint(_quanity.toString());
    _quanity++;
    notifyListeners();
  }

  void decrement() {
    debugPrint(_quanity.toString());

    _quanity--;
    notifyListeners();
  }

//  void trueLoading() {
//    debugPrint(_quanity.toString());
//    _quanity = true;
//    notifyListeners();
//  }
//
//  void falseLoading() {
//    debugPrint(_quanity.toString());
//    _quanity = false;
//    notifyListeners();
//  }
}
