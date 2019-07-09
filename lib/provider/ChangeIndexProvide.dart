import 'package:flutter/material.dart';

class ChangeIndexProvide extends ChangeNotifier {
  int indexChange = 0;

  changeIndex(int index) {
    this.indexChange = index;
    notifyListeners();
  }
}
