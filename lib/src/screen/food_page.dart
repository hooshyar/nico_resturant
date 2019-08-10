import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/product_model.dart';
import 'package:nico_resturant/src/screen/pager.dart';
import 'package:nico_resturant/src/services//loading_model.dart';
import 'package:nico_resturant/src/services/db.dart';
import 'package:provider/provider.dart';

DateTime theDate;
Product theFreakingProduct;
num theCalDebt;

class AppetizerPage extends StatefulWidget {
  @override
  _AppetizerPageState createState() => _AppetizerPageState();
}

class _AppetizerPageState extends State<AppetizerPage> {
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

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: MenuPager(),
          ),
        ),
      ],
    );
  }
}
