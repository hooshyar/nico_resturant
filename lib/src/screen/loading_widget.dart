import 'package:flutter/material.dart';
import 'package:nico_resturant/src/style/style.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: mainGradientColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Image.asset(
                    'lib/assets/Manager_logo_white.png',
                    scale: 1.5,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Please wait, loading ... ',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ErrorWidget extends StatefulWidget {
  @override
  _ErrorWidgetState createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(gradient: mainGradientColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Image.asset(
                    'lib/assets/Manager_logo_white.png',
                    scale: 1.5,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Please wait, loading ... ',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
