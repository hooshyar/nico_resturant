import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:nico_resturant/src/models/background_colors.dart';
import 'package:nico_resturant/src/models/food.dart';
import 'package:nico_resturant/src/models/menu.dart';
import 'package:nico_resturant/src/services/cart.dart';
import 'package:nico_resturant/src/services/setting_model.dart';
import 'package:nico_resturant/src/widgets/food_image.dart';
import 'package:nico_resturant/src/widgets/item_card.dart';
import 'package:nico_resturant/src/widgets/item_card_grid.dart';
import 'package:nico_resturant/src/widgets/shadows.dart';
import 'package:provider/provider.dart';

class MenuPager extends StatefulWidget {
  @override
  _MenuPagerState createState() => _MenuPagerState();

  final String type;
  MenuPager({this.type = 'food'});
}

class _MenuPagerState extends State<MenuPager> with TickerProviderStateMixin {
  List<NicoItem> typeItems = [];

  final PageController _backgroundPageController =
      PageController(viewportFraction: 1);
  final PageController _pageController = PageController();
  Color _backColor = Colors.red[50].withAlpha(250);
  int _cartQuantity = 0;
  bool firstEntry = true;

  @override
  void initState() {
    _getFilteredItems();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _backgroundPageController.dispose();
    super.dispose();
  }

  _getFilteredItems() {
    var _allItems = Menu.menu;
    for (int i = 0; i < _allItems.length; i++) {
      if (_allItems[i].type == widget.type) {
        typeItems.add(_allItems[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SettingModel settingProvider = Provider.of<SettingModel>(context);
    CartModel _item = Provider.of<CartModel>(context);
    timeDilation = 1.0;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: Container(decoration: BoxDecoration(color: _backColor))),
        typeItems.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: Text(
                  'No Item found sorry!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 45),
                ),
              )
            : Container(
                child: settingProvider.itemViewModel ==
                        'Grid '
                            'View'
                    ? Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(color: Colors.white10, offset: Offset(5, 5))
                        ]),
                        margin: EdgeInsets.only(
                            top: 150, bottom: 150, right: 15, left: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20)),
                          child: GridView.builder(
                            itemCount: typeItems.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 1,
                              childAspectRatio: 1.0,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Container(
                                  child: _contentWidgetGridView(
                                      typeItems[index],
                                      index,
                                      Alignment.center,
                                      2.0),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : PageView.builder(
                        itemCount: typeItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: _contentWidgetFullView(
                                      typeItems[index],
                                      index,
                                      Alignment.center,
                                      2.0),
                                ),
                              ),
                            ],
                          );
                        },
                        controller: _backgroundPageController,
                        onPageChanged: (index) {
                          _item.makeItZer();
                          setState(() {
                            _backColor =
                                colors[math.Random().nextInt(colors.length)];
                          });
                        },
                      ),
              ),
      ],
    );
  }

  _contentWidgetFullView(
      NicoItem food, int index, Alignment alignment, double resize) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 0),
                alignment: alignment,
                width: 170.0 * resize,
                height: 350.0 * resize,
                child: Stack(
                  children: <Widget>[
                    shadow2,
                    shadow1,
                    Stack(
                      children: <Widget>[
                        Container(
                          child: ItemCard(
                            food: food,

//                              onChangeNicoItemItem(index, _counter, food);
                          ),
                        ),
                      ],
                    ),
                    FoodImage(
                      imageAlign: FractionalOffset.topCenter,
                      food: food,
                      height: 250,
                      width: 250,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _contentWidgetGridView(
      NicoItem food, int index, Alignment alignment, double resize) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 0),
                alignment: alignment,
                // width: 170.0 * resize,
                // height: 170.0 * resize,
                child: Stack(
                  children: <Widget>[
                    shadow2,
                    shadow1,
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 50, left: 35, right: 10),
                          child: ItemCardGrid(
                            food: food,

//                              onChangeNicoItemItem(index, _counter, food);
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 0),
                      child: FoodImage(
                        imageAlign: FractionalOffset.topCenter,
                        food: food,
                        height: 180,
                        width: 180,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onChangeNicoItemItem(int index, int value, NicoItem food) {
    Provider.of<CartModel>(context).makeItZer();
//    setState(() {
//      Menu.menu[index] = food.copyWith(quantity: value);
//    });
  }
}
