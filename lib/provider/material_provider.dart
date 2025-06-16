import 'package:capstone_project_lms/api/sign_api.dart';
import 'package:flutter/cupertino.dart';

import '../models/materialbyclass_response.dart';

enum MaterialStatus { none, loading, error }

class GetMaterialClassProvider with ChangeNotifier {
  MaterialByClassResponse? _listClass = MaterialByClassResponse();
  MaterialByClassResponse? get listClass => _listClass;

  MaterialStatus _materialStatus = MaterialStatus.none;
  MaterialStatus get materialStatus => _materialStatus;

  changeStatus(MaterialStatus status) {
    _materialStatus = status;
  }

  getListClass(String classId) async {
    changeStatus(MaterialStatus.loading);
    try {
      _listClass = await API().materialClass(classId);
      changeStatus(MaterialStatus.none);
      notifyListeners();
    } catch (e) {
      changeStatus(MaterialStatus.error);
      notifyListeners();
    }
  }
}
