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
import 'package:nico_resturant/src/widgets/animated_transition.dart';
import 'package:nico_resturant/src/widgets/cart_button.dart';
import 'package:provider/provider.dart';

import 'services/db.dart';

class MyApp extends StatelessWidget {
  final db = DatabaseService();
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
          fontFamily: 'Dosis',
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
  Color _theChangeableColor = Colors.grey[800];

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
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInCubic);
      _selectedIndex = index;
    });
  }

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
//          backgroundColor: secondColor,
          bottomNavigationBar: BottomNavigationBar(
//            backgroundColor: secondColor,
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
                  height: 130,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: SafeArea(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 5, left: 5),
                              alignment: Alignment.bottomLeft,
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 180),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return FadeTransition(
                                      child: child, opacity: animation);
                                },
                                child: _theCart.listOfCartItems.isEmpty
                                    ? Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.centerLeft,
                                        key: ValueKey(1),
                                        child: Container(),
                                      )
                                    : Container(
                                        key: ValueKey(2),
                                        child: whichBtn(theCart: _theCart),

//                                        headerBtns(
//                                                color: Colors.green,
//                                                icon: FontAwesomeIcons.check,
//                                                text: 'ORDER',
//                                                onPressed: () {})
//                                            : headerBtns(
//                                                color: Colors.blue,
//                                                text: 'BILL',
//                                                icon:
//                                                    FontAwesomeIcons.moneyBill,
//                                                onPressed: () {}),
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
                              padding: EdgeInsets.only(bottom: 5, right: 5),
                              alignment: Alignment.bottomRight,
                              child: headerBtns(
                                  color: secondColor,
                                  icon: FontAwesomeIcons.conciergeBell,
                                  text: 'WAITER',
                                  onPressed: () {}),
                            ),
                          ),
                        ],
                      ),
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

  Widget whichBtn({CartModel theCart}) {
    if (theCart.listOfCartItems.isEmpty) {
      theCart.changeTheSit(sit: 'empty');
    }
    if (theCart.listOfCartItems.isNotEmpty &&
        theCart.theCartSit != 'placed' &&
        theCart.theCartSit != 'done') {
      theCart.changeTheSit(sit: 'order');
    }

    if (theCart.theCartSit == 'order') {
      return TheAnimatedWidget(
        child: headerBtns(
            color: Colors.green,
            icon: FontAwesomeIcons.check,
            text: 'ORDER',
            onPressed: () {
              theCart.changeTheSit(sit: 'placed');
              theCart.notifyListeners();
            }),
      );
    }
    if (theCart.theCartSit == 'placed') {
      return TheAnimatedWidget(
        child: headerBtns(
            color: Colors.blue,
            icon: FontAwesomeIcons.fileInvoice,
            text: 'BILL',
            onPressed: () {
              return _billPagePop();
//              Navigator.of(context).pushNamed('/CartPage');
            }),
      );
    }
    if (theCart.theCartSit == 'done') {
      return TheAnimatedWidget(
        child: headerBtns(
            color: Colors.green,
            icon: FontAwesomeIcons.check,
            text: 'REVIEW',
            onPressed: () {}),
      );
    }
  }

  Widget _footerCart(CartModel _theCart) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      height: 140,
      child: Column(
        children: <Widget>[
          Expanded(
            child: TheAnimatedWidget(
              child: Container(
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
//                                    decoration:
//                                        BoxDecoration(color: Colors.grey[800]),
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

//  billPageDialog() {}
  Future<void> _billPagePop() async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: TheAnimatedWidget(
                  child: Container(
                      color: secondColor,
                      height: 700,
                      width: 500,
                      child: CartPage())));
        });
  }

  void _removeItem(CartItem theItem, CartModel theCart) {
    var _itemIndex;

    for (int i = 0; i < theCart.listOfCartItems.length; i++) {
      if (theCart.listOfCartItems[i].itemId == theItem.itemId) {
        _itemIndex = i;
      }
    }
    theCart.listOfCartItems.removeAt(_itemIndex);
    theCart.notifyListeners();

    _listKey.currentState.removeItem(
      _itemIndex,
      (BuildContext context, Animation<double> animation) =>
          _buildItem(context, theItem, animation),
      duration: const Duration(milliseconds: 250),
    );
  }
}
