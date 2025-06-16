class ResponseLogin {
  bool? status;
  String? token;
  String? error;
  String? id;

  ResponseLogin({this.status, this.token, this.error, this.id});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    error = json['error'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    data['error'] = error;
    data['id'] = id;
    return data;
  }
}
