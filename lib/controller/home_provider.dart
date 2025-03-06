import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {

  int menuIndex = 0;
  PageController pageController=PageController();

  void setMenuIndex(int index) {
    menuIndex = index;
    notifyListeners();
  }

}