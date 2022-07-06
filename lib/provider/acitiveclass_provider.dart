import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/activeclass_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DataStatus { none, loading, error }

class ActiveClassProvider with ChangeNotifier {
  ActiveClassResponse _dataClass = ActiveClassResponse();
  ActiveClassResponse get dataClass => _dataClass;

  DataStatus _dataStatus = DataStatus.none;
  DataStatus get dataStatus => _dataStatus;


  changeStatus(DataStatus status) {
    _dataStatus = status;
    notifyListeners();
  }

  getActiveClass() async {
    changeStatus(DataStatus.loading);
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      String token = logindata.getString('token')!;
      String userId = logindata.getString('userId')!;
      _dataClass = await API().activeClass(userId, token);
      changeStatus(DataStatus.none);
      notifyListeners();
    } catch (e) {
      changeStatus(DataStatus.error);
      notifyListeners();
    }
  }
}
