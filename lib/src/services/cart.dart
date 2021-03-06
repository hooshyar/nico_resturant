import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/cart_model.dart';

class CartModel extends ChangeNotifier {
  ///internal private state of the Loading
  @override
  int _quanity = 0;
  int get quanity => _quanity;

  Color changableColor = Colors.grey[800];

  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  Cart _theCart;
  Cart get theCart => _theCart;

  @override
  String _theCartSit = 'open';
  String get theCartSit => _theCartSit;

//
  CartItem _cartItem;
  CartItem get cartItem => _cartItem;
//
  var listOfCartItems = [];

  void changeTheSit({String sit}) {
    _theCartSit = sit;
//    notifyListeners();
  }

  void addItemToCart(CartItem item) {
//    var index = listOfCartItems.length + 1;
    listOfCartItems[0] = item;
  }

  void whatColor() {
    if (listOfCartItems.isNotEmpty) {
      changableColor = Colors.green;
    }
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
