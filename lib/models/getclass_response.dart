class ResponseGetListClass {
  String? errors;
  bool? status;
  List<Data>? data;

  ResponseGetListClass({this.errors, this.status, this.data});

  ResponseGetListClass.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = errors;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  // List<int>? createdAt;
  String? createdBy;
  // List<int>? updatedAt;
  String? updatedBy;
  bool? isDeleted;
  String? name;
  String? room;
  String? code;
  String? status;
  List<Users>? users;

  Data(
      {this.id,
      // this.createdAt,
      this.createdBy,
      // this.updatedAt,
      this.updatedBy,
      this.isDeleted,
      this.name,
      this.room,
      this.code,
      this.status,
      this.users});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // createdAt = json['createdAt'].cast<int>();
    createdBy = json['createdBy'];
    // updatedAt = json['updatedAt'].cast<int>();
    updatedBy = json['updatedBy'];
    isDeleted = json['isDeleted'];
    name = json['name'];
    room = json['room'];
    code = json['code'];
    status = json['status'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    // data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['isDeleted'] = isDeleted;
    data['name'] = name;
    data['room'] = room;
    data['code'] = code;
    data['status'] = status;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? fullName;
  String? id;
  String? email;

  Users({this.fullName, this.id, this.email});

  Users.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['id'] = id;
    data['email'] = email;
    return data;
  }
}
