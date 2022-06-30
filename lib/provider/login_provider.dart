import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/login_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginState { none, loading, error }

class LoginProvider with ChangeNotifier {
  ResponseLogin _userResponse = ResponseLogin();
  ResponseLogin get userResponse => _userResponse;

  LoginState _loginState = LoginState.none;
  LoginState get loginState => _loginState;

  changeStatus(LoginState state) {
    _loginState = state;
    notifyListeners();
  }

  getUserData(String email, String password) async {
    changeStatus(LoginState.loading);
    try {
      _userResponse = await API().login(email, password);
      changeStatus(LoginState.none);
      notifyListeners();
    } catch (e) {
      changeStatus(LoginState.error);
      notifyListeners();
    }
  }

  setToken(String dataToken) async {
    try {
      var token = Jwt.parseJwt(dataToken);
      final userId = token['userId'];
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      logindata.setString('token', dataToken);
      logindata.setString('userId', userId);
      logindata.setBool('newUser', false);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  removeToken() async {
    late SharedPreferences logindata;
    logindata = await SharedPreferences.getInstance();
    logindata.remove('token');
    logindata.remove('userId');
  }
}
