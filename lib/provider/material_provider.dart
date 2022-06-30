import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/sign_api.dart';
import '../models/materialbyclass_response.dart';

class GetMaterialClassProvider with ChangeNotifier {
  MaterialByClassResponse _materialClass = MaterialByClassResponse();
  MaterialByClassResponse get materialClass => _materialClass;

  getListClass(String classId) async {
    try {
      late SharedPreferences logindata;
      logindata = await SharedPreferences.getInstance();
      String token = logindata.getString('token')!;
      _materialClass = await API().materialClass(classId, token);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
