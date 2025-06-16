import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3)); // Delay agar smooth
    SharedPreferences storage = await SharedPreferences.getInstance();
    var token = storage.getString('token');
    log("token: $token");
    // Cek apakah user sudah melihat onboarding
    if (token == null) {
      Navigator.popAndPushNamed(context, '/login', result: true);
    } else {
      Navigator.popAndPushNamed(context, '/main', result: true);
    }
  }
}
