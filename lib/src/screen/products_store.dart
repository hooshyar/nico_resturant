import 'package:flutter/material.dart';
import 'package:nico_resturant/src/style/style.dart';
import 'package:nico_resturant/src/widgets/widgets.dart';

class ProductsStore extends StatefulWidget {
  @override
  _ProductsStoreState createState() => _ProductsStoreState();
}

class _ProductsStoreState extends State<ProductsStore> {
  String chosenValueExpense = 'Today';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'List of Products',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: globalCard(
                margin: EdgeInsets.all(10.0),
                bgColor: secondColor.withOpacity(0.7),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Product Name'),
                        Container(
                          width: 10.0,
                        ),
                        Text('QTY'),
                      ],
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
