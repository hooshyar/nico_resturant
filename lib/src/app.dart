import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nico_resturant/src/models/cart_model.dart';
import 'package:nico_resturant/src/screen/cart_page.dart';
import 'package:nico_resturant/src/screen/login.dart';
import 'package:nico_resturant/src/screen/pager.dart';
import 'package:nico_resturant/src/screen/sell_form.dart';
import 'package:nico_resturant/src/screen/splash_screen.dart';
import 'package:nico_resturant/src/services//loading_model.dart';
import 'package:nico_resturant/src/services/bottom_nav_model.dart';
import 'package:nico_resturant/src/services/calculate_Totals.dart';
import 'package:nico_resturant/src/services/cart.dart';
import 'package:nico_resturant/src/services/connectivity.dart';
import 'package:nico_resturant/src/services/fetch_data.dart';
import 'package:nico_resturant/src/style/style.dart';
import 'package:provider/provider.dart';

import 'services/db.dart';

class MyApp extends StatelessWidget {
  final db = DatabaseService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ///Firebase Auth Provider which is a stream provider
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),

        ///Connectivity stream , so when the user is offline , notifies him
        StreamProvider<ConnectionStatus>.value(
          value: ConnectivityService().connectivityController.stream,
        ),

        ///Loading Provider , to change the ui when data is loading
        ChangeNotifierProvider(
          builder: (context) => LoadingModel(),
        ),

        ///Loading Provider , to change the ui when data is loading
        ChangeNotifierProvider(
          builder: (context) => FetchModel(),
        ),

        ChangeNotifierProvider(
          builder: (context) => CalculateTotals(),
        ),

        ChangeNotifierProvider(
          builder: (context) => BottomNav(),
        ),
        ChangeNotifierProvider(
          builder: (context) => CartModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Dosisd',
          primarySwatch: Colors.brown,
        ),
        home: SplashScreen(),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/HomePage': (BuildContext context) => MyHomePage(),
          '/LoginPage': (BuildContext context) => LoginPage(),
          '/SellForm': (BuildContext context) => SellForm(),
          '/CartPage': (BuildContext context) => CartPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _theCartWidget = Container();

//  GlobalKey _pageViewKey = GlobalKey();
  bool _showSecond = false;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    MenuPager(
      type: 'food',
    ),
    MenuPager(type: 'appetizer'),
    MenuPager(type: 'drink'),
    MenuPager(type: 'specials')
  ];

  void _onItemTapped(int index) {
    setState(() {
//        _pageController.jumpToPage(3);
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInCubic);
      _selectedIndex = index;
//      _moveBottomNav(index);
    });
  }

//  void _moveBottomNav(int index) {
//    _selectedIndex = index;
//  }

  @override
  Widget build(BuildContext context) {
    _listKey = Provider.of<CartModel>(context).listKey;
    final bottomNavIndex = Provider.of<BottomNav>(context);
    CartModel _theCart = Provider.of<CartModel>(context, listen: true);
    return WillPopScope(
      ///Disable going back
      onWillPop: () async => false,

      child: Scaffold(
          drawerScrimColor: Colors.transparent,
          key: scaffoldKey,
          backgroundColor: secondColor,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: secondColor,
            unselectedFontSize: 0,
            selectedFontSize: 16,
            iconSize: 32,
            unselectedItemColor: Colors.grey[600],
            elevation: 5,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.utensils),
                title: Text('Food'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.cheese),
                title: Text('Appetizer'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.wineGlassAlt),
                title: Text('Drink'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.medal),
                title: Text('featured'),
              ),
            ],
            currentIndex: bottomNavIndex.theIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
          body: Stack(
            children: <Widget>[
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Consumer<ConnectionStatus>(
                      builder: (context, connectionStatus, child) {
                        if (connectionStatus == ConnectionStatus.offline) {
                          return Text('offline');
                          //todo add interactivity
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: PageView.builder(
                                dragStartBehavior: DragStartBehavior.down,
                                onPageChanged: (value) {
                                  bottomNavIndex.changeTheIndex(value);
                                },
//                              key: _pageViewKey,
                                controller: _pageController,
                                itemCount: _widgetOptions.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      child: _widgetOptions.elementAt(index));
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: FlatButton.icon(
                              onPressed: () =>
                                  Navigator.of(context).pushNamed('/SellForm'),
                              label: Text(
                                'add',
                                style: TextStyle(color: secondColor),
                              ),
                              icon: Icon(
                                FontAwesomeIcons.plus,
                                color: secondColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'lib/assets/Nico_Logo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/CartPage'),
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: secondColor,
                                ),
                              )
//                            CartButton(),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0, right: 0, left: 0, child: _footerCart(_theCart))
            ],
          )),
    );
  }

  Widget _footerCart(CartModel _theCart) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      height: 140,
      child: Column(
        children: <Widget>[
          Expanded(
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 300),
              crossFadeState: _theCart.listOfCartItems.isEmpty
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
//                child: _theCart.listOfCartItems.isEmpty
              firstChild: Container(),
              secondChild: Container(
                height: 160,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.all(2.0),
//                                      color: secondColor.withOpacity(0.4),
                                    decoration:
                                        BoxDecoration(color: Colors.grey[800]),
//                                          boxShadow: [globalBoxShadow]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: AnimatedList(
                                          key: _listKey,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (context, index, animation) {
                                            CartItem _theItem =
                                                _theCart.listOfCartItems[index];
                                            return _buildItem(
                                                context, _theItem, animation);
                                          }),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
//                          borderRadius: BorderRadius.all(Radius.circular(20)),
//                          clipBehavior: Clip.antiAlias,
                          child: _floatingActionsBtns(_theCart),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, CartItem item, Animation<double> animation) {
    CartModel _theCart = Provider.of<CartModel>(context);
    return Container(
      child: FadeTransition(
        opacity: animation.drive(Tween(begin: 0.0, end: 1.0)),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2 / 2,
                  child: SizedBox(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    boxShadow: [globalBoxShadow],
                                    color: secondColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 5),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 20,
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        item.foodName,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 5,
              left: 0,
              child: Container(
                child: Image(
                  image: AssetImage(item.itemImage),
                  height: 60.0,
                  width: 60.0,
                ),
              ),
            ),
            Positioned(
              top: 1,
              right: 2,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(colors: [
                      Colors.red.withOpacity(0.8),
                      expiredSecondColor.withOpacity(0.9)
                    ])),
                height: 25,
                width: 25,
                child: Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      _removeItem(item, _theCart);
                    },
                    icon: Icon(
                      FontAwesomeIcons.minus,
                      size: 10,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 15,
              bottom: 15,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'X' + item.itemQTY.toString(),
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
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

  void _removeItem(CartItem theItem, CartModel theCart) {
    var _itemIndex;

    for (int i = 0; i < theCart.listOfCartItems.length; i++) {
      if (theCart.listOfCartItems[i].itemId == theItem.itemId) {
        _itemIndex = i;
      }
    }
    theCart.listOfCartItems.removeAt(_itemIndex);

    _listKey.currentState.removeItem(
      _itemIndex,
      (BuildContext context, Animation<double> animation) =>
          _buildItem(context, theItem, animation),
      duration: const Duration(milliseconds: 250),
    );
  }

  _floatingActionsBtns(CartModel theCart) {
    return Container(
      height: 160,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        child: Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          color: Colors.grey[800],
          padding: EdgeInsets.only(right: 5.0, bottom: 5, top: 5, left: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: AnimatedCrossFade(
                  duration: Duration(milliseconds: 200),
                  crossFadeState: theCart.listOfCartItems.isEmpty
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Container(),
                  secondChild: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            color: Colors.amber,
                            child: Text('btn2'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(height: 5),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        color: Colors.amber,
                        child: Text('btn1'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//  void _addAnItem() {
//    _data.insert(0, WordPair.random().toString());
//    listKey.currentState.insertItem(0);
//  }
//
//  void _removeLastItem() {
//    String itemToRemove = _data[0];
//
//    listKey.currentState.removeItem(
//      0,
//      (BuildContext context, Animation<double> animation) =>
//          _buildItem(context, itemToRemove, animation),
//      duration: const Duration(milliseconds: 250),
//    );
//
//    _data.removeAt(0);
//  }
//
//  void _removeAllItems() {
//    final int itemCount = _data.length;
//
//    for (var i = 0; i < itemCount; i++) {
//      String itemToRemove = _data[0];
//      listKey.currentState.removeItem(
//        0,
//        (BuildContext context, Animation<double> animation) =>
//            _buildItem(context, itemToRemove, animation),
//        duration: const Duration(milliseconds: 250),
//      );
//
//      _data.removeAt(0);
//    }
//  }

//  Future<CrossFadeState> _waitPlease() async {
//    await Future.delayed(Duration(seconds: 2)).then((onValue) {
//      return CrossFadeState.showSecond;
//    });
//  }
}
