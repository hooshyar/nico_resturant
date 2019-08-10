import 'package:flutter/material.dart';
import 'package:nico_resturant/src/screen/pager.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  String chosenValueExpense = 'Today';

  @override
  Widget build(BuildContext context) {
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
