import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nico_resturant/src/screen/expense_form.dart';
import 'package:nico_resturant/src/screen/expenses.dart';
import 'package:nico_resturant/src/screen/food_page.dart';
import 'package:nico_resturant/src/screen/home_widget.dart';
import 'package:nico_resturant/src/screen/login.dart';
import 'package:nico_resturant/src/screen/products_store.dart';
import 'package:nico_resturant/src/screen/sell_form.dart';
import 'package:nico_resturant/src/screen/splash_screen.dart';
import 'package:nico_resturant/src/services//loading_model.dart';
import 'package:nico_resturant/src/services/bottom_nav_model.dart';
import 'package:nico_resturant/src/services/calculate_Totals.dart';
import 'package:nico_resturant/src/services/connectivity.dart';
import 'package:nico_resturant/src/services/fetch_data.dart';
import 'package:nico_resturant/src/style/style.dart';
import 'package:nico_resturant/src/widgets/widgets.dart';
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
          '/ExpenseForm': (BuildContext context) => ExpanseForm(),
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
  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//  GlobalKey _pageViewKey = GlobalKey();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    FoodPage(),
    ExpensePage(),
    ProductsStore()
  ];

  void _onItemTapped(int index) {
    setState(() {
//        _pageController.jumpToPage(3);
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInCirc);
      _selectedIndex = index;
//      _moveBottomNav(index);
    });
  }

//  void _moveBottomNav(int index) {
//    _selectedIndex = index;
//  }

  @override
  Widget build(BuildContext context) {
    final bottomNavIndex = Provider.of<BottomNav>(context);
    return WillPopScope(
      ///Disable going back
      onWillPop: () async => false,
      child: Container(
        decoration:
            BoxDecoration(gradient: mainGradientColor, color: Colors.white10),
        child: Scaffold(
            key: scaffoldKey,
//            endDrawer: theEndDrawer(),
            backgroundColor: secondColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(130),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Container(
                    height: 130,
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FlatButton.icon(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed('/SellForm'),
                                label: Text('add'),
                                icon: Icon(FontAwesomeIcons.plus),
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
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.grey[800],
              elevation: 5,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money),
                  title: Text('Food'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.money_off),
                  title: Text('Expense'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text('Products'),
                ),
              ],
              currentIndex: bottomNavIndex.theIndex,
              selectedItemColor: Colors.white,
              onTap: _onItemTapped,
            ),
            body: Center(
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
//                  child: Text('offline'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: PageView.builder(
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
            ))),
      ),
    );
  }

  Widget theEndDrawer() {
    return Container(
      height: 500,
      width: 250,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text('The users'),
                ),
                Container(
                  height: 150,
                  width: 150,
                  child: Placeholder(),
                ),
                Text(
                  'The User Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey[800]),
                ),
                Container(alignment: Alignment.bottomCenter, child: Divider()),
              ],
            ),
            globalBtn(
                theGColor: mainGradientColor,
                theOnPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/LoginPage');
                },
                theTitle: 'Log out'),
          ],
        ),
      ),
    );
  }
}
