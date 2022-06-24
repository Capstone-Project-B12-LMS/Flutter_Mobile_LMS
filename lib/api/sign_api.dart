import 'package:capstone_project_lms/models/getclass_response.dart';
import 'package:capstone_project_lms/models/getuser_response_model.dart';
import 'package:capstone_project_lms/models/joinclass_response.dart';
import 'package:capstone_project_lms/models/login_response_model.dart';
import 'package:capstone_project_lms/models/register_response_model.dart';
import 'package:capstone_project_lms/models/updateuser_response.dart';
import 'package:dio/dio.dart';

class API {
  static String baseUrl =
      'http://ec2-34-212-169-254.us-west-2.compute.amazonaws.com';
  final Dio _dio = Dio();

  String loginApi = "$baseUrl/restapi/v1/login";
  String regisApi = "$baseUrl/restapi/v1/register";
  String getUser = "$baseUrl/restapi/v1/users";
  String updateUser = "$baseUrl/restapi/v1/users";
  String getClass = "$baseUrl/restapi/v1/class";
  String join = "$baseUrl/restapi/v1/class/join";

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
          await _dio.get("$getUser/$id", options: Options(headers: auth));
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
      Response response = await _dio.put("$updateUser/$id",
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
          await _dio.get(getClass, options: Options(headers: auth));
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
}
