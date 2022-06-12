import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/login_response_model.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  ResponseLogin _userResponse = ResponseLogin();
  ResponseLogin get userResponse => _userResponse;

  getUserData(String email, String password) async {
    try {
      _userResponse = await API().login(email, password);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
