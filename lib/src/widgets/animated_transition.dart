import 'package:flutter/material.dart';

class TheAnimatedWidget extends StatefulWidget {
  final Widget child;

  const TheAnimatedWidget({Key key, this.child}) : super(key: key);

  @override
  _TheAnimatedWidgetState createState() => _TheAnimatedWidgetState();
}

class _TheAnimatedWidgetState extends State<TheAnimatedWidget>
    with TickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curvedAnimation)
      ..addListener(() {});

    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return TheFadeIn(
      child: widget.child,
      opacity: animation,
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}

class TheFadeIn extends StatelessWidget {
  TheFadeIn({
    @required this.opacity,
    @required this.child,
  });

  final Widget child;
  final Animation<double> opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacity,
      child: child,
      builder: (context, child) {
        return FadeTransition(
          opacity: opacity,
          child: child,
        );
      },
    );
  }
}
