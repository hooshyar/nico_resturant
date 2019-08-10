import 'package:flutter/material.dart';
import 'package:nico_resturant/src/screen/pager.dart';

class Specials extends StatefulWidget {
  @override
  _SpecialsState createState() => _SpecialsState();
}

class _SpecialsState extends State<Specials> {
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
