import 'package:capstone_project_lms/models/activeclass_response.dart';
import 'package:capstone_project_lms/models/counselling_response.dart';
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
      'http://ec2-34-219-136-154.us-west-2.compute.amazonaws.com';
  final Dio _dio = Dio();

  String loginApi = "$baseUrl/restapi/v1/login";
  String regisApi = "$baseUrl/restapi/v1/register";
  String userUrl = "$baseUrl/restapi/v1/users";
  String join = "$baseUrl/restapi/v1/class/join";
  String classUrl = "$baseUrl/restapi/v1/class";
  String materialUrl = "$baseUrl/restapi/v1/material";

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

  Future<ResponseRegister> regis(
      String fullName, String email, String password) async {
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

  Future<ResponseUpdateUser> updateData(String id, String token, String email,
      String fullName, String telepon) async {
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

  Future<ResponseJoinClass> joinClass(
      String classCode, String token, String userId) async {
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

  Future<ResponseJoinClass> classPage(
      String page, String token, String userId) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    try {
      Response response =
          await _dio.get("$classUrl/$page/10", options: Options(headers: auth));
      return ResponseJoinClass.fromJson(response.data);
    } catch (e) {
      return ResponseJoinClass.fromJson({});
    }
  }

  Future<MaterialByClassResponse> materialClass(
      String classId, String token) async {
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

  Future<CounsellingResponse> counsellingRequest(String topic, String userId,
      String classId, String content, String token) async {
    Map<String, String> auth = {'Authorization': 'Bearer $token'};
    Map<String, String> data = {
      "topic": topic,
      "userId": userId,
      "classId": classId,
      "content": content
    };
    try {
      Response response = await _dio.post("$baseUrl/restapi/v1/guidances",
          options: Options(headers: auth),data: data);
      return CounsellingResponse.fromJson(response.data);
    } catch (e) {
      return CounsellingResponse.fromJson({});
    }
  }
}
