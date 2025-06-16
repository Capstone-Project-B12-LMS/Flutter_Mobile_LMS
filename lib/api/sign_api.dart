// import 'package:capstone_project_lms/models/activeclass_response.dart';
// import 'package:capstone_project_lms/models/activityhistory_response.dart';
// import 'package:capstone_project_lms/models/class_pagination_response.dart';
// import 'package:capstone_project_lms/models/counselling_response.dart';
// import 'package:capstone_project_lms/models/feedback_response.dart';
// import 'package:capstone_project_lms/models/getclass_response.dart';
// import 'package:capstone_project_lms/models/getuser_response_model.dart';
// import 'package:capstone_project_lms/models/joinclass_response.dart';
// import 'package:capstone_project_lms/models/login_response_model.dart';
// import 'package:capstone_project_lms/models/register_response_model.dart';
// import 'package:capstone_project_lms/models/updateuser_response.dart';
// import 'package:dio/dio.dart';

// import '../models/materialbyclass_response.dart';

// class API {
//   static String baseUrl = 'http://10.0.2.2:3000';
//   final Dio _dio = Dio();

//   String loginApi = "$baseUrl/login";
//   String regisApi = "$baseUrl/register";
//   String userUrl = "$baseUrl/users";
//   String join = "$baseUrl/class/join";
//   String classUrl = "$baseUrl/class";
//   String materialUrl = "$baseUrl/material";
//   String feedback = "$baseUrl/feedbacks/class";
//   String activity = "$baseUrl/activityhistory/user";
//   String paginationClass = "$baseUrl/class";

//   Future<ResponseLogin> login(String email, String password) async {
//     Map<String, String> data = {"email": email, "password": password};
//     try {
//       Response response = await _dio.post(loginApi,
//           data: data, options: Options(contentType: Headers.jsonContentType));
//       return ResponseLogin.fromJson(response.data);
//     } catch (e) {
//       return ResponseLogin.fromJson({});
//     }
//   }

//   Future<ResponseRegister> regis(
//       String fullName, String email, String password) async {
//     Map<String, String> data = {
//       "fullName": fullName,
//       "email": email,
//       "password": password
//     };
//     try {
//       Response response = await _dio.post(regisApi,
//           data: data, options: Options(contentType: Headers.jsonContentType));
//       return ResponseRegister.fromJson(response.data);
//     } catch (e) {
//       return ResponseRegister.fromJson({});
//     }
//   }

//   Future<ResponseGetUser> userData(String id, String token) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     try {
//       Response response =
//           await _dio.get("$userUrl/$id", options: Options(headers: auth));
//       return ResponseGetUser.fromJson(response.data);
//     } catch (e) {
//       return ResponseGetUser.fromJson({});
//     }
//   }

//   Future<ResponseUpdateUser> updateData(String id, String token, String email,
//       String fullName, String telepon) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     Map<String, String> data = {
//       'email': email,
//       'fullName': fullName,
//       'telepon': telepon
//     };
//     try {
//       Response response = await _dio.put("$userUrl/$id",
//           data: data,
//           options:
//               Options(headers: auth, contentType: Headers.jsonContentType));
//       return ResponseUpdateUser.fromJson(response.data);
//     } catch (e) {
//       return ResponseUpdateUser.fromJson({});
//     }
//   }

//   Future<ResponseGetListClass> getListClass(String token) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     try {
//       Response response =
//           await _dio.get(classUrl, options: Options(headers: auth));
//       return ResponseGetListClass.fromJson(response.data);
//     } catch (e) {
//       return ResponseGetListClass.fromJson({});
//     }
//   }

//   Future<ResponseJoinClass> joinClass(
//       String classCode, String token, String userId) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     Map<String, String> data = {"classCode": classCode, "userId": userId};
//     try {
//       Response response = await _dio.post(join,
//           data: data,
//           options:
//               Options(headers: auth, contentType: Headers.jsonContentType));
//       return ResponseJoinClass.fromJson(response.data);
//     } catch (e) {
//       return ResponseJoinClass.fromJson({});
//     }
//   }

//   Future<ResponseJoinClass> classPage(
//       String page, String token, String userId) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     try {
//       Response response =
//           await _dio.get("$classUrl/$page/10", options: Options(headers: auth));
//       return ResponseJoinClass.fromJson(response.data);
//     } catch (e) {
//       return ResponseJoinClass.fromJson({});
//     }
//   }

//   Future<MaterialByClassResponse> materialClass(
//       String classId, String token) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     try {
//       Response response = await _dio.get("$materialUrl/class/$classId",
//           options: Options(headers: auth));
//       return MaterialByClassResponse.fromJson(response.data);
//     } catch (e) {
//       return MaterialByClassResponse.fromJson({});
//     }
//   }

//   Future<ActiveClassResponse> activeClass(String userId, String token) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     try {
//       Response response = await _dio.get("$userUrl/class/$userId/ACTIVE",
//           options: Options(headers: auth));
//       return ActiveClassResponse.fromJson(response.data);
//     } catch (e) {
//       return ActiveClassResponse.fromJson({});
//     }
//   }

//   Future<CounsellingResponse> counsellingRequest(String topic, String userId,
//       String classId, String content, String token) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     Map<String, String> data = {
//       "topic": topic,
//       "userId": userId,
//       "classId": classId,
//       "content": content
//     };
//     try {
//       Response response = await _dio.post("$baseUrl/guidances",
//           options: Options(headers: auth), data: data);
//       return CounsellingResponse.fromJson(response.data);
//     } catch (e) {
//       return CounsellingResponse.fromJson({});
//     }
//   }

//   Future<FeedbackResponse> feedbackClass(String classId, String token) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     try {
//       Response response =
//           await _dio.get("$feedback/$classId", options: Options(headers: auth));
//       return FeedbackResponse.fromJson(response.data);
//     } catch (e) {
//       return FeedbackResponse.fromJson({});
//     }
//   }

//   Future<ActivityHistoryResponse> activityHistory(
//       String userId, String token) async {
//     Map<String, String> auth = {'Authorization': 'Bearer $token'};
//     try {
//       Response response =
//           await _dio.get("$activity/$userId", options: Options(headers: auth));
//       return ActivityHistoryResponse.fromJson(response.data);
//     } catch (e) {
//       return ActivityHistoryResponse.fromJson({});
//     }
//   }

//   Future<List<ListClassPaginationResponse>> listClassPagination(
//       int page, int size) async {
//     Map<String, String> auth = {'Authorization': 'Bearer '};
//     try {
//       Response response = await _dio.get("$paginationClass/$page/$size",
//           options: Options(headers: auth));
//       return [ListClassPaginationResponse.fromJson(response.data)];
//     } catch (e) {
//       return [ListClassPaginationResponse.fromJson({})];
//     }
//   }
// }
import 'dart:developer';
import 'dart:io';

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
import 'package:shared_preferences/shared_preferences.dart';

import '../models/materialbyclass_response.dart';

// --- Singleton Pattern untuk Dio ---
class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio _dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: Platform.isAndroid
          ? 'http://10.0.2.2:5678/webhook'
          : 'http://localhost:5678/webhook-test/', // Base URL untuk emulator
      connectTimeout: const Duration(seconds: 10), // Durasi timeout
      receiveTimeout: const Duration(seconds: 10),
    ));

    // Optional: Tambahkan interceptor untuk logging request/response
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Dio get dio => _dio;
}

// --- Kelas API Utama ---
class API {
  // Gunakan Dio dari DioClient singleton
  final Dio _dio = DioClient().dio;

  // Endpoint yang lebih bersih, menggunakan base URL dari Dio
  static const String _loginPath = "/login";
  static const String _usersPath = "/users";
  static const String _joinClassPath = "/classes";
  static const String _classPath = "/class";
  static const String _materialPath = "/material";
  static const String _feedbackPath = "/feedbacks/class";
  static const String _activityPath = "/activityhistory/user";
  static const String _guidancePath = "/guidances";

  // Helper untuk mendapatkan Options dengan token
  Options _authOptions(String token) {
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  // --- Login ---
  Future<ResponseLogin?> login(String email, String password) async {
    try {
      final response = await _dio.post(_loginPath,
          data: {"username": email, "password": password},
          options: Options(contentType: Headers.jsonContentType));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      log("response data: ${response.data}");
      prefs.setString('token', response.data['token']);
      prefs.setString('userId', response.data['id']);
      return ResponseLogin.fromJson(response.data);
    } on DioException catch (e) {
      log('Login error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred during login: $e');
      return null;
    }
  }

  // --- Register ---
  Future<ResponseRegister?> regis(String fullName, String email,
      String password, String telp, String username) async {
    try {
      Map data = {
        "fullname": fullName,
        "email": email,
        "password": password,
        "telepon": telp,
        "username": username
      };
      final response = await _dio.post(
        "regis",
        data: data,
      );
      return ResponseRegister.fromJson(response.data);
    } on DioException catch (e) {
      log('Registration error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred during registration: $e');
      return null;
    }
  }

  // --- Get User Data ---
  Future<ResponseGetUser?> userData(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await _dio.get(
          "/b46774d6-a354-48e1-a7da-05296eb19be8/users/$id",
          options: _authOptions(token ?? ''));
      return ResponseGetUser.fromJson(response.data);
    } on DioException catch (e) {
      log('Get user data error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred while getting user data: $e');
      return null;
    }
  }

  // --- Update User Data ---
  Future<ResponseUpdateUser?> updateData(
      String id, String email, String fullName, String telepon) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await _dio.put("$_usersPath/$id",
          data: {'email': email, 'fullName': fullName, 'telepon': telepon},
          options: _authOptions(token ?? '')
            ..contentType = Headers.jsonContentType);
      return ResponseUpdateUser.fromJson(response.data);
    } on DioException catch (e) {
      log('Update user data error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred during user data update: $e');
      return null;
    }
  }

  // --- Get List Class ---
  Future<ResponseGetListClass?> getListClass(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await Dio().get(
          "http://localhost:5678/webhook-test/b46774d6-a354-48e1-a7da-05296eb19be8/$id/class/active",
          options: _authOptions(token ?? ''));
      return ResponseGetListClass.fromJson(response.data);
    } on DioException catch (e) {
      log('Get list class error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred while getting class list: $e');
      return null;
    }
  }

  // --- Join Class ---
  Future<ResponseJoinClass?> joinClass(String classCode, String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await _dio.post("$_joinClassPath/$classCode/join",
          data: {"userId": userId},
          options: _authOptions(token ?? '')
            ..contentType = Headers.jsonContentType);
      return ResponseJoinClass.fromJson(response.data);
    } on DioException catch (e) {
      log('Join class error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred during class join: $e');
      return null;
    }
  }

  // --- Class Pagination (menggunakan ListClassPaginationResponse) ---
  // Perhatikan bahwa parameter 'page' di sini kemungkinan besar adalah offset/halaman dan 'size' adalah limit
  // Sesuaikan nama endpoint di Express Anda jika tidak sesuai dengan `_classPath/page/size`
  Future<List<ListClassPaginationResponse>?> listClassPagination(
    int page,
    int size,
  ) async {
    // Menambahkan parameter token
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      // Pastikan token disertakan dalam header
      final response = await _dio.get("$_classPath/$page/$size",
          options: _authOptions(token ?? ''));
      // Dio biasanya akan mengembalikan List<dynamic> jika respons adalah array JSON
      return (response.data as List)
          .map((item) => ListClassPaginationResponse.fromJson(item))
          .toList();
    } on DioException catch (e) {
      log('Class pagination error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred during class pagination: $e');
      return null;
    }
  }

  // --- Get Material By Class ---
  Future<MaterialByClassResponse?> materialClass(
    String classId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await _dio.get("$_materialPath/class/$classId",
          options: _authOptions(token ?? ''));
      return MaterialByClassResponse.fromJson(response.data);
    } on DioException catch (e) {
      log('Get material by class error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred while getting class materials: $e');
      return null;
    }
  }

  // --- Get Active Class ---
  Future<ActiveClassResponse?> activeClass(
    String userId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await _dio.get("class/active",
          queryParameters: {"userId": userId},
          options: _authOptions(token ?? ''));
      return ActiveClassResponse.fromJson(response.data);
    } on DioException catch (e) {
      log('Get active class error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred while getting active classes: $e');
      return null;
    }
  }

  // --- Counselling Request ---
  Future<CounsellingResponse?> counsellingRequest(
    String topic,
    String userId,
    String classId,
    String content,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await _dio.post(_guidancePath,
          data: {
            "topic": topic,
            "userId": userId,
            "classId": classId,
            "content": content
          },
          options: _authOptions(token ?? '')
            ..contentType = Headers.jsonContentType);
      return CounsellingResponse.fromJson(response.data);
    } on DioException catch (e) {
      log('Counselling request error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred during counselling request: $e');
      return null;
    }
  }

  // --- Get Feedback by Class ---
  Future<FeedbackResponse?> feedbackClass(
    String classId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await _dio.get("$_feedbackPath/$classId",
          options: _authOptions(token ?? ''));
      return FeedbackResponse.fromJson(response.data);
    } on DioException catch (e) {
      log('Get feedback by class error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred while getting feedback: $e');
      return null;
    }
  }

  // --- Get Activity History ---
  Future<ActivityHistoryResponse?> activityHistory(
    String userId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await _dio.get("$_activityPath/$userId",
          options: _authOptions(token ?? ''));
      return ActivityHistoryResponse.fromJson(response.data);
    } on DioException catch (e) {
      log('Get activity history error: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      log('An unexpected error occurred while getting activity history: $e');
      return null;
    }
  }
}
