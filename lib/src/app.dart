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
          fontFamily: 'Noto Kufi Arabic',
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
          key: scaffoldKey,
//            endDrawer: theEndDrawer(),
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
                  bottom: 30, right: 30, left: 30, child: _footerCart(_theCart))
            ],
          )),
    );
  }

  Widget _footerCart(CartModel _theCart) {
    return Container(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: AnimatedCrossFade(
                duration: Duration(milliseconds: 200),
                crossFadeState: _theCart.listOfCartItems.isEmpty
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
//                child: _theCart.listOfCartItems.isEmpty
                firstChild: Container(),
                secondChild: Container(
                  height: 200,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(20),
                            color: secondColor,
                            child: AnimatedList(
                                key: _listKey,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index, animation) {
                                  CartItem _theItem =
                                      _theCart.listOfCartItems[index];

                                  return _buildItem(
                                      context, _theItem, animation);
                                })
                            //todo cart as child
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, CartItem item, Animation<double> animation) {
    return Container(
      child: FadeTransition(
        opacity: animation.drive(Tween(begin: 0.0, end: 1.0)),
        child: SizedBox(
          height: 200,
          child: Container(
              margin: EdgeInsets.all(10),
              color: Colors.black38,
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage(item.itemImage),
                    height: 100.0,
                    width: 100.0,
                  ),
                  Text(item.foodName),
                ],
              )),
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
