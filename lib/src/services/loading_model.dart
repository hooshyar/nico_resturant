import 'package:flutter/material.dart';

class LoadingModel extends ChangeNotifier {
  ///internal private state of the Loading
  @override
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void changeTheLoading() {
    debugPrint(_isLoading.toString());
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void trueLoading() {
    debugPrint(_isLoading.toString());
    _isLoading = true;
    notifyListeners();
  }

  void falseLoading() {
    debugPrint(_isLoading.toString());
    _isLoading = false;
    notifyListeners();
  }
}
