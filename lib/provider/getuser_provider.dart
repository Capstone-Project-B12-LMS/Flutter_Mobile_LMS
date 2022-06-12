import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/getuser_response_model.dart';
import 'package:flutter/cupertino.dart';

class GetUserProvider with ChangeNotifier {
  ResponseGetUser _userDataProvider = ResponseGetUser();
  ResponseGetUser get userDataProvider => _userDataProvider;

  getUserData(String id, String token) async {
    try {
      final d = await API().userData(id, token);
      _userDataProvider = d;
      print('dari provider : ${_userDataProvider.data?.email}');
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
