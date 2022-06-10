import 'package:flutter/cupertino.dart';

class NavbarProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  getIndexNavbar(int index) {
    try {
      _selectedIndex = index;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
