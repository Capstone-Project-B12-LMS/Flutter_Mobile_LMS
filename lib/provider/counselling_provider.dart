import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/counselling_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounsellingProvdider with ChangeNotifier {
  CounsellingResponse _dataCounselling = CounsellingResponse();
  CounsellingResponse get dataCounselling => _dataCounselling;

  reqCounselling(String topic, String classId, String content) async {
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      String token = logindata.getString('token')!;
      String userId = logindata.getString('userId')!;
      _dataCounselling = await API().counsellingRequest(topic, userId, classId, content, token);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
