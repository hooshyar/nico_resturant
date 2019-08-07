import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nico_resturant/src/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = Auth();

  @override
  void initState() {
    navigatePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  navigatePage() async {
    await auth.currentUser().then((user) {
      if (user != null) {
        debugPrint('user is already signed in ');
        debugPrint('user is : $user');
        return Navigator.of(context).pushNamed('/HomePage');
      } else {
        debugPrint(' user shoud login ');
        return Navigator.of(context).pushNamed('/LoginPage');
      }
    });
  }
}
