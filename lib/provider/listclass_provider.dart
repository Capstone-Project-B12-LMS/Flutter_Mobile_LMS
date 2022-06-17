import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:capstone_project_lms/models/getclass_response.dart';
import 'package:flutter/cupertino.dart';

class GetListClassProvider with ChangeNotifier {
  ResponseGetListClass _listClass = ResponseGetListClass();
  ResponseGetListClass get listClass => _listClass;

  getListClass(String token) async {
    try {
      _listClass = await API().getListClass(token);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
