import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/feedback_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackProvider with ChangeNotifier {
  FeedbackResponse _feedbackResponse = FeedbackResponse();
  FeedbackResponse get feedbackResponse => _feedbackResponse;
  getFeedback(String classId) async {
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      String token = logindata.getString('token')!;
      _feedbackResponse = await API().feedbackClass(classId, token);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
