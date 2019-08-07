import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nico_resturant/src/config/config.dart';
import 'package:nico_resturant/src/models/resturant_model.dart';
import 'package:nico_resturant/src/services/bottom_nav_model.dart';
import 'package:nico_resturant/src/services/db.dart';
import 'package:nico_resturant/src/services/fetch_data.dart';
import 'package:nico_resturant/src/style/style.dart';
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
//      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavIndex = Provider.of<BottomNav>(context);
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: FutureBuilder(
                        future: Provider.of<FetchModel>(context).fetchFoods(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return LinearProgressIndicator();
                          } else {
                            return PageView.builder(
//                                controller: _pageController,
//                                pageSnapping: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  Food doc = snapshot.data[index];
//                      var _foodItem = Food.fromSnapshot(doc);
                                  return Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      child: CachedNetworkImage(
                                          fit: BoxFit.fitHeight,
                                          imageUrl: doc.imageUrl,
                                          placeholder: (context, url) =>
                                              Container(
                                                height: 200,
                                                child:
                                                    LinearProgressIndicator(),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error)),
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: FutureBuilder(
                        future: Provider.of<FetchModel>(context).fetchFoods(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return LinearProgressIndicator();
                          } else {
                            return PageView.builder(
                                controller: _pageController,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  Food doc = snapshot.data[index];
                                  bool active;

                                  active = index == currentPage;

//                      var _foodItem = Food.fromSnapshot(doc);
//                                  return Container(
//                                    padding: EdgeInsets.all(10.0),
//                                    child: ClipRRect(
//                                      borderRadius:
//                                          BorderRadius.all(Radius.circular(20)),
//                                      child: CachedNetworkImage(
//                                          fit: BoxFit.fitHeight,
//                                          imageUrl: doc.imageUrl,
//                                          placeholder: (context, url) =>
//                                              Container(
//                                                height: 200,
//                                                child:
//                                                    LinearProgressIndicator(),
//                                              ),
//                                          errorWidget: (context, url, error) =>
//                                              new Icon(Icons.error)),
//                                    ),
//                                  );
                                  return _buildStoryPage(doc, active);
                                });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_buildStoryPage(Food food, bool active) {
  // Animated Properties
  final double blur = active ? 30 : 0;
  final double offset = active ? 20 : 0;
  final double top = active ? 100 : 200;

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOutQuint,
    margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(food.imageUrl),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black87,
              blurRadius: blur,
              offset: Offset(offset, offset))
        ]),
  );
}

Widget theCardList(
    {theJob = 'fdasfd', theCustomer = 'customerName', thePrice = '2000'}) {
  return Container(
//                          height: 50,
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
