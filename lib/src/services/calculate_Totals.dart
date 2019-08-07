import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/resturant_model.dart';

class CalculateTotals extends ChangeNotifier {
  ///internal private state of the Loading
  @override
  num _totallFood = 0;
  num get totalFood => _totallFood;

  calculateTotalFood(List<Food> Foods) {
    if (Foods.length != null && Foods.isNotEmpty) {
      _totallFood = 0;
      debugPrint(_totallFood.toString());
      for (var i = 0; i < Foods.length; i++) {}
      notifyListeners();
      return _totallFood;
    } else {
      notifyListeners();
      return 0;
    }
  }
}
