import 'dart:core';

import 'package:fluro/fluro.dart'as flurro;
import 'package:flutter/material.dart';

import 'package:nico_resturant/src/screen/details.dart';

class Routes {
  static final flurro.Router _router = new flurro.Router();

  static void initRoutes() {
    _router.define("/detail/:id", handler:  flurro.Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new DetailPage(params["id"]);
    }));
  }

  static void navigateTo(context, String route) {
    _router.navigateTo(context, route);
  }
}
