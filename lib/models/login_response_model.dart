class ResponseLogin {
  bool? status;
  String? token;
  String? error;

  ResponseLogin({this.status, this.token, this.error});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    data['error'] = error;
    return data;
  }
}
