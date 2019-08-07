import 'package:flutter/material.dart';
import 'package:nico_resturant/src/config/config.dart';
import 'package:nico_resturant/src/style/style.dart';

class DebtPage extends StatefulWidget {
  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  String chosenValueDebt = 'Today';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
//              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text('Debts of '),
                  ),
                  VerticalDivider(
                    indent: 1,
//                          color: Colors.black,
                    width: 20,
                  ),
                  Container(
                    height: 40,
                    child: DropdownButton<String>(
                      underline: Container(),
                      value: chosenValueDebt,
                      onChanged: (String newValue) {
                        setState(() {
                          chosenValueDebt = newValue;
                        });
                      },
                      items: <String>['Today', 'Week', 'Month', 'Year']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              value,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 250,
                    margin:
                        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        boxShadow: [globalBoxShadow],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            'Debts',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
//                          height: 50,
                            margin: EdgeInsets.only(
                                bottom: 10, right: 10, left: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('dasf'),
                                Text('dfsafd'),
                                Text('2000 $moneySign'),
                                Text('12/12/22'),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
              decoration: BoxDecoration(
                boxShadow: [globalBoxShadow],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Total : ',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  VerticalDivider(
                    color: secondColor,
                  ),
                  Text(
                    '1450 $moneySign',
                    style: TextStyle(
                      letterSpacing: 1,
                      shadows: [globalBoxShadow],
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
