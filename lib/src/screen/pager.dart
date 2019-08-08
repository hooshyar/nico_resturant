import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:nico_resturant/src/models/background_colors.dart';
import 'package:nico_resturant/src/models/food.dart';
import 'package:nico_resturant/src/models/menu.dart';
import 'package:nico_resturant/src/widgets/animated_circle.dart';
import 'package:nico_resturant/src/widgets/food_image.dart';
import 'package:nico_resturant/src/widgets/item_card.dart';
import 'package:nico_resturant/src/widgets/rectangle_indicator.dart';
import 'package:nico_resturant/src/widgets/shadows.dart';

class MenuPager extends StatefulWidget {
  @override
  _MenuPagerState createState() => new _MenuPagerState();
}

const double _kViewportFraction = 0.75;

class _MenuPagerState extends State<MenuPager> with TickerProviderStateMixin {
  final PageController _backgroundPageController = new PageController();
  final PageController _pageController =
      new PageController(viewportFraction: _kViewportFraction);
  ValueNotifier<double> selectedIndex = new ValueNotifier<double>(0.0);
  Color _backColor = const Color.fromRGBO(240, 232, 223, 1.0);
  int _counter = 0;
  int _cartQuantity = 0;
  AnimationController controller, scaleController;
  Animation<double> scaleAnimation;
  bool firstEntry = true;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    scaleController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 175));
    scaleAnimation = new Tween<double>(begin: 1.0, end: 1.20).animate(
        new CurvedAnimation(parent: scaleController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    controller.dispose();
    scaleController.dispose();
    _pageController.dispose();
    _backgroundPageController.dispose();
    super.dispose();
  }

  Future<Null> playAnimation() async {
    try {
      if (controller.isCompleted) {
        controller.reset();
        await controller.forward().whenComplete(() {
          scaleController.forward().whenComplete(() {
            scaleController.reverse();
            setState(() {
              _cartQuantity = _cartQuantity + _counter;
              _counter = 0;
            });
          });
        });
      } else {
        await controller.forward().whenComplete(() {
          setState(() {
            if (firstEntry) {
              firstEntry = false;
            }
            _cartQuantity = _cartQuantity + _counter;
            _counter = 0;
          });
          scaleController.forward().whenComplete(() {
            scaleController.reverse();
          });
        });
      }
    } on TickerCanceled {}
  }

  onChangeNicoFoodItem(int index, int value, NicoFood food) {
    setState(() {
      Menu.menu[index] = food.copyWith(quantity: value);
    });
  }

  _contentWidget(NicoFood food, int index, Alignment alignment, double resize) {
    return Container(
      child: new Stack(
        children: <Widget>[
          new Center(
            child: new Container(
              alignment: alignment,
              width: 300.0 * resize,
              height: 550.0 * resize,
              child: new Stack(
                children: <Widget>[
                  shadow2,
                  shadow1,
                  Stack(
                    children: <Widget>[
                      Container(
                        child: new ItemCard(
                          food: food,
                          increment: () {
                            setState(() {
                              _counter++;
                            });
                            onChangeNicoFoodItem(index, _counter, food);
                          },
                          decrement: () {
                            setState(() {
                              _counter--;
                            });
                            onChangeNicoFoodItem(index, _counter, food);
                          },
                        ),
                      ),
                    ],
                  ),
                  new FoodImage(food: food),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Iterable<Widget> _buildPages() {
    final List<Widget> pages = <Widget>[];
    for (int index = 0; index < 10; index++) {
      var alignment = Alignment.center.add(new Alignment(
          (selectedIndex.value - index) * _kViewportFraction, 0.0));
      var resizeFactor =
          (1 - (((selectedIndex.value - index).abs() * 0.2).clamp(0.0, 1.0)));
      pages.add(_contentWidget(
        Menu.menu[index],
        index,
        alignment,
        resizeFactor,
      ));
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    final screenHeight = MediaQuery.of(context).size.height;

    return new Stack(
      children: <Widget>[
        new Positioned.fill(
            child: new Container(
                decoration: new BoxDecoration(color: _backColor))),
//        new CustomAppBar(),
        new Align(
            alignment: Alignment.bottomCenter,
            child: new Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: new RectangleIndicator(_backgroundPageController,
                    Menu.menu.length, 6.0, Colors.grey[400], Colors.black))),
        new PageView.builder(
          itemCount: Menu.menu.length,
          itemBuilder: (BuildContext context, int itemCount) {
            return Container();
          },
          controller: _backgroundPageController,
          onPageChanged: (index) {
            setState(() {
              _backColor = colors[new math.Random().nextInt(colors.length)];
            });
          },
        ),
        new NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                notification is ScrollUpdateNotification) {
              selectedIndex.value = _pageController.page;
              if (_backgroundPageController.page != _pageController.page) {
                _backgroundPageController.position
                    // ignore: deprecated_member_use
                    .jumpToWithoutSettling(
                        _pageController.position.pixels / _kViewportFraction);
              }
              setState(() {});
            }
            return false;
          },
          child: new PageView(
            controller: _pageController,
            children: _buildPages(),
          ),
        ),
        Positioned.fill(
          top: 30.0,
          right: 5.0,
          bottom: 100.0,
          child: new StaggerAnimation(controller: controller.view),
        ),
        firstEntry
            ? Container()
            : new Align(
                alignment: Alignment.topRight,
                child: new ScaleTransition(
                  scale: scaleAnimation,
                  child: new Container(
                    height: 20.0,
                    width: 20.0,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 30.0, right: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.amber),
                    child: new Text('$_cartQuantity',
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12.0)),
                  ),
                ),
              ),
      ],
    );
  }
}
