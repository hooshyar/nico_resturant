import 'package:flutter/material.dart';

class BottomNav extends ChangeNotifier {
  ///internal private state of the Loading
  @override
  int _theIndex = 0;

  int get theIndex => _theIndex;

  void changeTheIndex(int index) {
    debugPrint(_theIndex.toString());
    _theIndex = index;
    notifyListeners();
  }
}
