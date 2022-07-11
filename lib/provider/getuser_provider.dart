import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/getuser_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserProvider with ChangeNotifier {
  ResponseGetUser _userDataProvider = ResponseGetUser();
  ResponseGetUser get userDataProvider => _userDataProvider;

  String _userId = '';
  String get userId => _userId;
  String _userToken = '';
  String get userToken => _userToken;

  getUserData() async {
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      final token = logindata.getString('token');
      final id = logindata.getString('userId');
      _userId = id!;
      _userToken = token!;
      _userDataProvider = await API().userData(id, token);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  clearData() {
    _userDataProvider = ResponseGetUser();
    notifyListeners();
  }
}
