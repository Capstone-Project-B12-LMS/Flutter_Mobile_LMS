import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/activeclass_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveClassProvider with ChangeNotifier {
  ActiveClassResponse _dataClass = ActiveClassResponse();
  ActiveClassResponse get dataClass => _dataClass;

  getActiveClass() async {
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      String token = logindata.getString('token')!;
      String userId = logindata.getString('userId')!;
      _dataClass = await API().activeClass(userId, token);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
