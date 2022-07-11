import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/activityhistory_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DataStatusHistory { none, loading, error }

class ActivityHistoryProvider with ChangeNotifier {
  ActivityHistoryResponse _activityHistoryProvider = ActivityHistoryResponse();
  ActivityHistoryResponse get activityHistoryProvider =>
      _activityHistoryProvider;

  DataStatusHistory _dataStatusHistory = DataStatusHistory.none;
  DataStatusHistory get dataStatusHistory => _dataStatusHistory;

  changeStatus(DataStatusHistory status) {
    _dataStatusHistory = status;
    notifyListeners();
  }

  history() async {
    changeStatus(DataStatusHistory.loading);
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      String token = logindata.getString('token')!;
      String userId = logindata.getString('userId')!;
      _activityHistoryProvider = await API().activityHistory(userId, token);
      changeStatus(DataStatusHistory.none);
      notifyListeners();
    } catch (e) {
      changeStatus(DataStatusHistory.error);
      notifyListeners();
    }
  }
}
