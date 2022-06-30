import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/getclass_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetListClassProvider with ChangeNotifier {
  ResponseGetListClass _listClass = ResponseGetListClass();
  ResponseGetListClass get listClass => _listClass;

  getListClass() async {
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      String token = logindata.getString('token')!;
      _listClass = await API().getListClass(token);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
