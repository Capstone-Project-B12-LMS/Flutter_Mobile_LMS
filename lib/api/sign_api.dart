import 'package:capstone_project_lms/models/login_response_model.dart';
import 'package:capstone_project_lms/models/register_response_model.dart';
import 'package:dio/dio.dart';

class LoginApi {
  static String baseUrl =
      'http://ec2-34-212-169-254.us-west-2.compute.amazonaws.com';
  final Dio _dio = Dio();

  var loginApi = "$baseUrl/restapi/login";
  var regisApi = "$baseUrl/restapi/register";

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

  Future<ResponseRegister> regis(String fullName,String email, String password) async {
    var data = {"fullName":fullName,"email": email, "password": password};
    try {
      Response response = await _dio.post(regisApi,
          data: data, options: Options(contentType: Headers.jsonContentType));
      return ResponseRegister.fromJson(response.data);
    } catch (e) {
      return ResponseRegister.fromJson({});
    }
  }

  Future<ResponseRegister> tes(String fullName,String email, String password) async {
    var data = {"fullName":fullName,"email": email, "password": password};
    try {
      Response response = await _dio.post(regisApi,
          data: data, options: Options(contentType: Headers.jsonContentType));
      return ResponseRegister.fromJson(response.data);
    } catch (e) {
      return ResponseRegister.fromJson({});
    }
  }
}
