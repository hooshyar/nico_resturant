import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat globalDateShowFormatting = DateFormat.yMd();

final globalTextColorDarker = Colors.grey[700];
final globalTextColorDark = Colors.grey[600];
final globalTextColorLight = Colors.white70;

final mainColor = const Color(0xffDED9CE);
final secondColor = const Color(0xff5B5751);
final globalAppBarColor = Colors.cyan[100];
final globalBtnColor = Colors.indigo[300];

final availableFirstColor = const Color(0xff88F562);
final availableSecondColor = const Color(0xff0B4303);
final occupiedFirstColor = const Color(0xff3023AE);
final occupiedSecondColor = const Color(0xffC86DD7);
final expiredFirstColor = const Color(0xffF5515F);
final expiredSecondColor = const Color(0xff9F041B);
final soonFirstColor = const Color(0xffFAD961);
final soonSecondColor = const Color(0xffF76B1C);

///gradients

final mainGradientColorReverse = LinearGradient(
  colors: [secondColor, mainColor],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final mainGradientColor = LinearGradient(
  colors: [mainColor, secondColor],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
final loginContainerGradientColor = LinearGradient(
  colors: [Colors.white, Colors.cyan[50]],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final Color theGlobalColor = Colors.black12;
final Gradient purpleGradient = LinearGradient(colors: [
  Colors.purple[900],
  Colors.purple[800],
  Colors.purple[900],
]);

final availableGradientColor = LinearGradient(colors: [
  theGlobalColor,
  theGlobalColor,
  theGlobalColor,
  theGlobalColor,
//  Colors.greenAccent[400],
  availableFirstColor
], begin: Alignment.topLeft, end: Alignment.bottomRight);

//todo new color
//final availableGradientColor = LinearGradient(
//    colors: [Colors.white, Colors.white, Colors.lightGreenAccent[600]],
//    begin: Alignment.centerRight,
//    end: Alignment.centerLeft);

final occupiedGradientColor = LinearGradient(colors: [
  theGlobalColor,
  theGlobalColor,
  theGlobalColor,
  theGlobalColor,
//  Colors.deepPurple,
  occupiedFirstColor,
], begin: Alignment.topLeft, end: Alignment.bottomRight);
final expiredGradientColor = LinearGradient(colors: [
  theGlobalColor,
  theGlobalColor,
  theGlobalColor,
  theGlobalColor,
//  Colors.redAccent,
  expiredFirstColor,
], begin: Alignment.topLeft, end: Alignment.bottomRight);
final soonGradientColor = LinearGradient(colors: [
  theGlobalColor,
  theGlobalColor,
  theGlobalColor,
  theGlobalColor,
//  Colors.amber,
  soonFirstColor,
], begin: Alignment.topLeft, end: Alignment.bottomRight);

final globalBoxShadow = BoxShadow(
    color: secondColor.withOpacity(0.5),
    blurRadius: 8.0,
    offset: Offset(4.0, 1.0),
    spreadRadius: 1.0);

final globalBtnShadow = BoxShadow(
    color: secondColor.withOpacity(0.3),
    blurRadius: 4.0,
    offset: Offset(1.0, 2.0),
    spreadRadius: 2);

final globalBoxShadow2 = BoxShadow(
    color: secondColor,
    blurRadius: 5.0,
    spreadRadius: 5.0,
    offset: Offset(3.0, 3.0));

final TextStyle globalLabelTextStyle =
    TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.w200, fontSize: 16);

globalInputDecoration(String theText) {
  return InputDecoration(
      hasFloatingPlaceholder: false,
      hintText: theText,
      hintStyle: TextStyle(color: globalTextColorDark),
      labelText: theText,
      labelStyle: TextStyle(color: globalTextColorDark),
      suffixText: theText,
      suffixStyle: TextStyle(color: globalTextColorDark),
      filled: true,
      fillColor: Colors.white,
      prefixStyle: TextStyle(color: globalTextColorDark),
      helperStyle: TextStyle(color: globalTextColorDark),
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.all(15.0));
}
