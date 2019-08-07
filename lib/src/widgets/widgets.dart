import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nico_resturant/src/models/resturant_model.dart';
import 'package:nico_resturant/src/style/style.dart';

//outline border radius text field
Widget formTextField({
  String hintText: 'hint',
  String labelText: 'label text',
  TextEditingController controller,
}) {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: TextFormField(
      textDirection: TextDirection.ltr,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    ),
  );
}

Widget rtlFormTextField({
  String hintText: 'hint',
  String labelText: 'label text',
  TextEditingController controller,
}) {
  return TextFormField(
    textDirection: TextDirection.rtl,
    controller: controller,
    decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white, width: 1.0, style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
  );
}

//outline border radius text field
Widget formTextFieldNoBorder({
  onEditingCompleted,
  theIcon,
  textInputType,
  TextEditingController controller,
  String theLabel = 'the Label',
  String theHelper = 'the Helper',

//  fillColor,
  validator,
}) {
  return Container(
//    color: mainColor,
    decoration: BoxDecoration(
//        boxShadow: [globalBoxShadow],
        color: secondColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
//    margin: EdgeInsets.only(top: 10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
                keyboardType: textInputType,
                onEditingComplete: onEditingCompleted,
                validator: validator,
                autocorrect: false,
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    theIcon,
                    color: Colors.black87,
                    size: 16,
                  ),
                  hintText: theHelper,
                  prefixStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  contentPadding: EdgeInsets.only(top: 15, bottom: 15),
                  border: InputBorder.none,
                )),
          ),
        ),
      ],
    ),
  );
}

//outline border radius text field
Widget formPasswordText({
  TextEditingController controller,
  String theLabel = 'the Label',
  String theHelper = 'the Helper',
  validator,
}) {
  return Container(
    padding: EdgeInsets.only(left: 10.0, right: 10.0),
    child: Row(
      children: <Widget>[
//        Container(
//            width: 80,
//            child: Text(
//              theLabel,
//              style: TextStyle(color: globalTextColorDark),
//            )),
        Expanded(
          child: TextFormField(
              style: TextStyle(fontSize: 18),
              autocorrect: false,
              obscureText: true,
              controller: controller,
              validator: validator,
              decoration: InputDecoration(
                hintText: theHelper,
                prefixStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
                contentPadding: EdgeInsets.only(top: 15, bottom: 15),
                border: InputBorder.none,
              )),
        ),
      ],
    ),
  );
}

Widget globalBtn({
  String theTitle = 'title',
  Function theOnPressed,
  LinearGradient theGColor,
  theShadow,
  Color textColor = Colors.white,
  spColor,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: theShadow ?? [globalBtnShadow],
      gradient: theGColor,
    ),
    height: 50,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: FlatButton(
        splashColor: spColor,
        textColor: Colors.white,
        child: Text(
          theTitle,
          style: TextStyle(color: textColor),
        ),
        color: Colors.transparent,
//      elevation: 0,
        onPressed: theOnPressed,
      ),
    ),
  );
}

Widget globalCircleBtn({
  Widget theTitle,
  Function theOnPressed,
  Color spColor,
  LinearGradient theGColor,
  Color textColor = Colors.white,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      boxShadow: [globalBoxShadow],
      gradient: theGColor,
    ),
    height: 35,
    width: 35,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      child: FlatButton(
        padding: EdgeInsets.all(5.0),
        splashColor: spColor,
        textColor: Colors.white,
        child: theTitle,
        color: Colors.transparent,
//      elevation: 0,
        onPressed: theOnPressed,
      ),
    ),
  );
}

Widget globalRoundedRectBtn({
  Widget theTitle,
  Function theOnPressed,
  Color spColor,
  LinearGradient theGColor,
  Color textColor = Colors.white,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [globalBoxShadow],
      gradient: theGColor,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: FlatButton(
        padding: EdgeInsets.all(5.0),
        splashColor: spColor,
        textColor: Colors.white,
        child: theTitle,
        color: Colors.transparent,
//      elevation: 0,
        onPressed: theOnPressed,
      ),
    ),
  );
}

Widget globalCard({double width, double height, bgColor, margin, child}) {
  return Container(
      child: child,
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
//          boxShadow: [globalBoxShadow],
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))));
}

Widget singleDataQuery(List<Food> snapshots, index) {
  return globalCard(
      bgColor: Colors.white,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        initiallyExpanded: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: secondColor,
                  ),
                  VerticalDivider(
                    width: 10,
                  ),
                  Text(snapshots[index].foodName),
                ],
              ),
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.bottomRight,
                    width: 100,
                    child: Text(snapshots[index].foodPrice.toString()))),
          ],
        ),
      ));
}

Widget detailsCard({icon1, text1, icon2, text2, icon3, text3}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon1,
              size: 16,
              color: secondColor,
            ),
            VerticalDivider(),
            Text(text1),
          ],
        ),
      ),
      Row(
        children: <Widget>[
          Icon(
            icon2,
            size: 16,
            color: secondColor,
          ),
          VerticalDivider(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(text2),
          ),
        ],
      ),
    ],
  );
}
