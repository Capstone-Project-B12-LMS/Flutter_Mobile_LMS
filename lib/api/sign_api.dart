import 'package:capstone_project_lms/models/login_response_model.dart';
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

  Future<ResponseLogin> regis(String fullname,String email, String password) async {
    var data = {"fullName":fullname,"email": email, "password": password};
    try {
      Response response = await _dio.post(regisApi,
          data: data, options: Options(contentType: Headers.jsonContentType));
      return ResponseLogin.fromJson(response.data);
    } catch (e) {
      return ResponseLogin.fromJson({});
    }
  }
}
