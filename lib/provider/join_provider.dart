import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/joinclass_response.dart';
import 'package:flutter/cupertino.dart';

class JoinProvider with ChangeNotifier {
  String _token = '';
  String get token => _token;
  String _userId = '';
  String get userId => _userId;
  ResponseJoinClass _joinresClass = ResponseJoinClass();
  ResponseJoinClass get joinResClass => _joinresClass;

  savetokenid(String token, String id) async {
    try {
      _token = token;
      _userId = id;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  joinClass(String token, String userId, String classCode) async {
    try {
      _joinresClass = await API().joinClass(classCode, token, userId);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
