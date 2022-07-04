import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/sign_api.dart';
import '../models/materialbyclass_response.dart';

enum DetailState { none, loading, error }

class GetMaterialClassProvider with ChangeNotifier {
  MaterialByClassResponse _materialClass = MaterialByClassResponse();
  MaterialByClassResponse get materialClass => _materialClass;

  DetailState _detailState = DetailState.none;
  DetailState get detailState => _detailState;

  changeStatus(DetailState state) {
    _detailState = state;
    notifyListeners();
  }

  getListClass(String classId) async {
    changeStatus(DetailState.loading);
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      String token = logindata.getString('token')!;
      _materialClass = await API().materialClass(classId, token);
      changeStatus(DetailState.none);
      notifyListeners();
    } catch (e) {
      changeStatus(DetailState.error);
      notifyListeners();
    }
  }

  clearData() {
    _materialClass = MaterialByClassResponse();
    notifyListeners();
  }
}
