import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nico_resturant/src/style/style.dart';

class CartButton extends StatelessWidget {
  CartButton({this.counter, this.addToCart});
  final int counter;
  final VoidCallback addToCart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.0,
      height: 50.0,
      child: new MaterialButton(
        highlightColor: Colors.amber[400],
        onPressed: counter == 0 ? null : addToCart,
        elevation: counter == 0 ? 10.0 : 5.0,
        color: counter == 0 ? Colors.grey[350] : Colors.amber,
        child: new Icon(const IconData(0xe807, fontFamily: 'fontello'),
            size: 20.0, color: secondColor),
      ),
    );
  }
}

Widget headerBtns({Color color, String text, IconData icon, onPressed}) {
  return Container(
    width: 140,
    height: 50,
    child: FlatButton.icon(
      textColor: color,
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 24,
      ),
      label: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    ),
  );
}
