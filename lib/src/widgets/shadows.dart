import 'package:flutter/material.dart';

final shadow1 = new Center(
  child: new Container(
    height: 0.0,
    width: 100.0,
    margin: const EdgeInsets.only(top: 250.0),
    decoration:
        new BoxDecoration(shape: BoxShape.rectangle, boxShadow: <BoxShadow>[
      new BoxShadow(
          color: Colors.grey[300],
          blurRadius: 50.0,
          spreadRadius: 40.0,
          offset: new Offset(0.0, 0.0)),
    ]),
  ),
);

final shadow2 = new Center(
  child: new Container(
    height: 50.0,
    width: 100.0,
    margin: const EdgeInsets.only(top: 250.0),
    decoration:
        new BoxDecoration(shape: BoxShape.circle, boxShadow: <BoxShadow>[
      new BoxShadow(
          color: Colors.black87,
          blurRadius: 7.0,
          spreadRadius: 50.0,
          offset: new Offset(0.0, -20.0)),
//      new BoxShadow(
//          color: Colors.black38,
//          blurRadius: 5.0,
//          spreadRadius: 45.0,
//          offset: new Offset(0.0, 30.0)),
//      new BoxShadow(
//          color: Colors.black45,
//          blurRadius: 10.0,
//          spreadRadius: 30.0,
//          offset: new Offset(0.0, 30.0)),
//      new BoxShadow(
//          color: Colors.black54,
//          blurRadius: 10.0,
//          spreadRadius: 10.0,
//          offset: new Offset(0.0, 35.0)
//      ),
    ]),
  ),
);
