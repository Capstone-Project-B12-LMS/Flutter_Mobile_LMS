import 'package:flutter/cupertino.dart';

class SplashProvider with ChangeNotifier {
  bool _isTrue = false;
  bool get isTrue => _isTrue;

  setBool(bool dataBool) async {
    try {
      _isTrue = dataBool;
      // print(_isTrue);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
