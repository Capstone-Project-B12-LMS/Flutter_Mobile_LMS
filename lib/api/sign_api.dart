import 'package:capstone_project_lms/models/getuser_response_model.dart';
import 'package:capstone_project_lms/models/login_response_model.dart';
import 'package:capstone_project_lms/models/register_response_model.dart';
import 'package:capstone_project_lms/models/updateuser_response.dart';
import 'package:dio/dio.dart';

class API {
  static String baseUrl =
      'http://ec2-34-212-169-254.us-west-2.compute.amazonaws.com';
  final Dio _dio = Dio();

  var loginApi = "$baseUrl/restapi/v1/login";
  var regisApi = "$baseUrl/restapi/v1/register";
  var getUser = "$baseUrl/restapi/v1/users";
  var updateUser = "$baseUrl/restapi/v1/users";

  Future<ResponseLogin> login(String email, String password) async {
    var data = {"email": email, "password": password};
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
    var data = {"fullName": fullName, "email": email, "password": password};
    try {
      Response response = await _dio.post(regisApi,
          data: data, options: Options(contentType: Headers.jsonContentType));
      return ResponseRegister.fromJson(response.data);
    } catch (e) {
      return ResponseRegister.fromJson({});
    }
  }

  Future<ResponseGetUser> userData(String id, String token) async {
    var auth = {'Authorization': 'Bearer $token'};
    try {
      Response response =
          await _dio.get("$getUser/$id", options: Options(headers: auth));
      print('dari API: ${response.data}');
      return ResponseGetUser.fromJson(response.data);
    } catch (e) {
      print('dari API: $e');
      return ResponseGetUser.fromJson({});
    }
  }

  Future<ResponseUpdateUser> updateData(String id, String token, String email,
      String fullName, String telepon) async {
    var auth = {'Authorization': 'Bearer $token'};
    var data = {'email': email, 'fullName': fullName, 'telepon': telepon};
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
}
