import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/product_model.dart';
import 'package:nico_resturant/src/services//loading_model.dart';
import 'package:nico_resturant/src/services/db.dart';
import 'package:provider/provider.dart';

DateTime theDate;
Product theFreakingProduct;
num theCalDebt;

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  String chosenTimeValueFood = 'Today';
  final db = DatabaseService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    var _theLoading = Provider.of<LoadingModel>(context).isLoading;

    return Container(
      child: Text('Food'),
      padding: EdgeInsets.only(top: 10),
    );
  }
}
