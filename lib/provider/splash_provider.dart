import 'package:flutter/cupertino.dart';

class SplashProvider with ChangeNotifier {
  bool _isTrue = false;
  bool get isTrue => _isTrue;

  setBool(bool dataBool) async {
    try {
      _isTrue = dataBool;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

}
