import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nico_resturant/src/config/config.dart';
import 'package:nico_resturant/src/models/resturant_model.dart';
import 'package:nico_resturant/src/screen/pager.dart';
import 'package:nico_resturant/src/services/bottom_nav_model.dart';
import 'package:nico_resturant/src/services/db.dart';
import 'package:nico_resturant/src/style/style.dart';
import 'package:nico_resturant/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  final _db = DatabaseService();
  List<int> todayNumbers = [250, 160, 90];
  List<int> weekNumbers = [3200, 440, 2760];
  List<int> monthNumbers = [7100, 1450, 5650];
  List<int> yearNumbers = [0, 0, 0];
  List<int> instanceNumbers = [250, 160, 90];
  int currentPage = 0;
  String chosenTimeValue = 'ئه‌مرۆ';

  @override
  void initState() {
    // TODO: implement initState
    _pageController.addListener(() {
      int next = _pageController.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavIndex = Provider.of<BottomNav>(context);
    return Container(
      child: Column(children: <Widget>[
        Expanded(
          child: MenuPager(),

//          child: Row(
//            children: <Widget>[
//              Expanded(
//                flex: 1,
//                child: Container(
//                  child: FutureBuilder(
//                    future: Provider.of<FetchModel>(context).fetchFoods(),
//                    builder: (context, AsyncSnapshot snapshot) {
//                      if (!snapshot.hasData) {
//                        return LinearProgressIndicator();
//                      } else {
//                        return PageView.builder(
//                            controller: _pageController,
//                            itemCount: snapshot.data.length,
//                            itemBuilder: (context, index) {
//                              Food doc = snapshot.data[index];
//                              bool active;
//
//                              active = index == currentPage;
//                              return _buildStoryPage(doc, active);
//                            });
//                      }
//                    },
//                  ),
//                ),
//              ),
//            ],
//          ),
        ),
//        Expanded(
//          flex: 1,
//          child: Container(
//            color: mainColor,
//          ),
//        ),
      ]),
    );
  }
}

_buildStoryPage(Food food, bool active) {
  // Animated Properties
  final double blur = active ? 30 : 0;
  final double offset = active ? 20 : 0;
  final double top = active ? 25 : 75;

  return Stack(
    children: <Widget>[
      Container(
        height: 400,
        child: AnimatedContainer(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: food.imageUrl,
                placeholder: (context, str) => LinearProgressIndicator()),
          ),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOutQuint,
          margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black87,
                    blurRadius: blur,
                    offset: Offset(offset, offset))
              ]),
        ),
      ),
      Align(
        heightFactor: 3.5,
        widthFactor: 2,
        alignment: Alignment.bottomCenter,
        child: Container(
//          alignment: Alignment.bottomCenter,
          width: 350, height: 130,
          child: globalCard(
              margin: EdgeInsets.only(right: 50, left: 20, bottom: 10, top: 30),
              bgColor: mainColor,
              child: Container(
                child: Text(
                  food.foodName,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              )),
        ),
      ),
      //todo starts
      Align(
        heightFactor: 0.7,
        widthFactor: 1,
//        alignment: Alignment.bottomCenter,
        child: Container(
//          alignment: Alignment.bottomCenter,
          width: 350, height: 100,
          child: globalCard(
              margin: EdgeInsets.only(right: 50, left: 20, bottom: 10, top: 30),
              child: Container(
                //todo here goes the starts
                child: Text(
                  food.foodName,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              )),
        ),
      ),
    ],
  );
}

Widget theCardList(
    {theJob = 'fdasfd', theCustomer = 'customerName', thePrice = '2000'}) {
  return Container(
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(flex: 3, child: Container(child: Text(theJob))),
          Expanded(flex: 1, child: Container(child: Text(theCustomer))),
          Expanded(
              flex: 1, child: Container(child: Text(thePrice + moneySign))),
        ],
      ));
}

//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return null;
//  }
//}
