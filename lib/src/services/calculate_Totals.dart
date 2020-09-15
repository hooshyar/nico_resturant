import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/resturant_model.dart';

class CalculateTotals extends ChangeNotifier {
  ///internal private state of the Loading
  @override
  num _totalFood = 0;
  num get totalFood => _totalFood;

  calculateTotalFood(List<Food> Foods) {
    if (Foods.length != null && Foods.isNotEmpty) {
      _totalFood = 0;
      debugPrint(_totalFood.toString());
      for (var i = 0; i < Foods.length; i++) {}
      notifyListeners();
      return _totalFood;
    } else {
      notifyListeners();
      return 0;
    }
  }
}
