import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/feedback_response.dart';
import 'package:flutter/cupertino.dart';

class FeedbackProvider with ChangeNotifier {
  FeedbackResponse? _feedbackResponse = FeedbackResponse();
  FeedbackResponse? get feedbackResponse => _feedbackResponse;
  getFeedback(String classId) async {
    try {
      _feedbackResponse = await API().feedbackClass(classId);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
