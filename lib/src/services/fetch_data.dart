import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/resturant_model.dart';
import 'package:nico_resturant/src/services/db.dart';

class FetchModel with ChangeNotifier {
  var _db = DatabaseService();
  DateTime now = DateTime.now();

  ///internal private state of the Loading
//  @override
  num totalToday = 0;
  num totalFood = 0;
  num totalFoodToday = 0;
  num totalFoodWeek = 0;
  num totalFoodMonth = 0;
  num totalFoodYear = 0;
  num showFood = 0;
  num totalPayablePrice = 0;
  bool doesHaveData = true;

  List<Food> foods = [];

  Future<List<Food>> fetchFoods() async {
    List<DocumentSnapshot> docs = await _db.fetchSnapshot();
    debugPrint('List of docs length is : ' + docs.length.toString());
    final List<Food> _foods = [];
    if (docs.isNotEmpty) {
      docs.forEach((doc) => _foods.add(Food.fromSnapshot(doc)));
    }
    return _foods;
  }

  filterFoods(String theDate) async {
    await fetchFoods().then((value) {
      if (value.isNotEmpty) {
        foods = value;
        debugPrint(foods.length.toString() + 'and' + value.length.toString());
      }
    });
  }
}
