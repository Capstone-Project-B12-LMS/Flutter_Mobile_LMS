import 'package:capstone_project_lms/models/activeclass_response.dart';
import 'package:capstone_project_lms/models/activityhistory_response.dart';
import 'package:capstone_project_lms/models/class_pagination_response.dart';
import 'package:capstone_project_lms/models/counselling_response.dart';
import 'package:capstone_project_lms/models/feedback_response.dart';
import 'package:capstone_project_lms/models/getclass_response.dart';
import 'package:capstone_project_lms/models/getuser_response_model.dart';
import 'package:capstone_project_lms/models/joinclass_response.dart';
import 'package:capstone_project_lms/models/login_response_model.dart';
import 'package:capstone_project_lms/models/register_response_model.dart';
import 'package:capstone_project_lms/models/updateuser_response.dart';
import 'package:dio/dio.dart';

import '../models/materialbyclass_response.dart';

class API {
  static String baseUrl =
      'http://ec2-34-223-3-198.us-west-2.compute.amazonaws.com/restapi/v1';
  final Dio _dio = Dio();

  String loginApi = "$baseUrl/login";
  String regisApi = "$baseUrl/register";
  String userUrl = "$baseUrl/users";
  String join = "$baseUrl/class/join";
  String classUrl = "$baseUrl/class";
  String materialUrl = "$baseUrl/material";
  String feedback = "$baseUrl/feedbacks/class";
  String activity = "$baseUrl/activityhistory/user";
  String paginationClass = "$baseUrl/class";

  Future<ResponseLogin> login(String email, String password) async {
    Map<String, String> data = {"email": email, "password": password};
    try {
      Response response = await _dio.post(loginApi,
          data: data, options: Options(contentType: Headers.jsonContentType));
      return ResponseLogin.fromJson(response.data);
    } catch (e) {
      return ResponseLogin.fromJson({});
    }
  }

  Future<ResponseRegister> regis(String fullName, String email, String password) async {
    Map<String, String> data = {
      "fullName": fullName,
      "email": email,
      "password": password
    };
    try {
      Response response = await _dio.post(regisApi,
          data: data, options: Options(contentType: Headers.jsonContentType));
      return ResponseRegister.fromJson(response.data);
    } catch (e) {
      return ResponseRegister.fromJson({});
    }
  }

  Future<ResponseGetUser> userData(String id, String token) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    try {
      Response response =
          await _dio.get("$userUrl/$id", options: Options(headers: auth));
      return ResponseGetUser.fromJson(response.data);
    } catch (e) {
      return ResponseGetUser.fromJson({});
    }
  }

  Future<ResponseUpdateUser> updateData(String id, String token, String email,String fullName, String telepon) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    Map<String, String> data = {
      'email': email,
      'fullName': fullName,
      'telepon': telepon
    };
    try {
      Response response = await _dio.put("$userUrl/$id",
          data: data,
          options:
              Options(headers: auth, contentType: Headers.jsonContentType));
      return ResponseUpdateUser.fromJson(response.data);
    } catch (e) {
      return ResponseUpdateUser.fromJson({});
    }
  }

  Future<ResponseGetListClass> getListClass(String token) async {
Map<String, String> auth = {'Authorization': 'Bearer $token'};
    try {
      Response response =
          await _dio.get(classUrl, options: Options(headers: auth));
      return ResponseGetListClass.fromJson(response.data);
    } catch (e) {
      return ResponseGetListClass.fromJson({});
    }
  }

  Future<ResponseJoinClass> joinClass(String classCode, String token, String userId) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    Map<String, String> data = {"classCode": classCode, "userId": userId};
    try {
      Response response = await _dio.post(join,
          data: data,
          options:
              Options(headers: auth, contentType: Headers.jsonContentType));
      return ResponseJoinClass.fromJson(response.data);
    } catch (e) {
      return ResponseJoinClass.fromJson({});
    }
  }

  Future<ResponseJoinClass> classPage(String page, String token, String userId) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    try {
      Response response =
          await _dio.get("$classUrl/$page/10", options: Options(headers: auth));
      return ResponseJoinClass.fromJson(response.data);
    } catch (e) {
      return ResponseJoinClass.fromJson({});
    }
  }

  Future<MaterialByClassResponse> materialClass(String classId, String token) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    try {
      Response response = await _dio.get("$materialUrl/class/$classId",
          options: Options(headers: auth));
      return MaterialByClassResponse.fromJson(response.data);
    } catch (e) {
      return MaterialByClassResponse.fromJson({});
    }
  }

  Future<ActiveClassResponse> activeClass(String userId, String token) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    try {
      Response response = await _dio.get("$userUrl/class/$userId/ACTIVE",
          options: Options(headers: auth));
      return ActiveClassResponse.fromJson(response.data);
    } catch (e) {
      return ActiveClassResponse.fromJson({});
    }
  }

  Future<CounsellingResponse> counsellingRequest(String topic, String userId,String classId, String content, String token) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    Map<String, String> data = {
      "topic": topic,
      "userId": userId,
      "classId": classId,
      "content": content
    };
    try {
      Response response = await _dio.post("$baseUrl/guidances",
          options: Options(headers: auth), data: data);
      return CounsellingResponse.fromJson(response.data);
    } catch (e) {
      return CounsellingResponse.fromJson({});
    }
  }

  Future<FeedbackResponse> feedbackClass(String classId, String token) async {Map<String, String> auth = {'Authorization': 'Bearer $token'};
    try {
      Response response =
          await _dio.get("$feedback/$classId", options: Options(headers: auth));
      return FeedbackResponse.fromJson(response.data);
    } catch (e) {
      return FeedbackResponse.fromJson({});
    }
  }

  Future<ActivityHistoryResponse> activityHistory(String userId, String token) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    try {
      Response response =
          await _dio.get("$activity/$userId", options: Options(headers: auth));
      return ActivityHistoryResponse.fromJson(response.data);
    } catch (e) {
      return ActivityHistoryResponse.fromJson({});
    }
  }

  Future<List<ListClassPaginationResponse>> listClassPagination(int page, int size) async {
    Map<String, String> auth = {'Authorization': 'Bearer '};
    try {
      Response response = await _dio.get("$paginationClass/$page/$size",
          options: Options(headers: auth));
      return [ListClassPaginationResponse.fromJson(response.data)];
    } catch (e) {
      return [ListClassPaginationResponse.fromJson({})];
    }
  }
}
