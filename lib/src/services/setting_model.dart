import 'dart:core';

import 'package:flutter/material.dart';

class SettingModel extends ChangeNotifier {
  ///internal private state of the Loading
  @override
  String itemViewModel = 'Full Screen View'; // 'Grid View'

  void changeItemViewModel(String viewModel) {
    itemViewModel = viewModel;
    notifyListeners();
    debugPrint(itemViewModel.toString());
  }

  int _quanity = 0;

  int get quanity => _quanity;

  var listOfCartItems = [];

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
}
