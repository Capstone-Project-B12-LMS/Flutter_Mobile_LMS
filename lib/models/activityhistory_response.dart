class ActivityHistoryResponse {
  String? errors;
  bool? status;
  List<Data>? data;

  ActivityHistoryResponse({this.errors, this.status, this.data});

  ActivityHistoryResponse.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? content;

  Data({this.id, this.user, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['content'] = content;
    return data;
  }
}

class User {
  String? id;
  String? createdBy;
  String? updatedBy;
  bool? isDeleted;
  String? fullName;
  String? email;
  String? password;
  String? telepon;
  List<Roles>? roles;
  bool? enabled;
  List<Authorities>? authorities;
  String? username;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? credentialsNonExpired;

  User(
      {this.id,
      this.createdBy,
      this.updatedBy,
      this.isDeleted,
      this.fullName,
      this.email,
      this.password,
      this.telepon,
      this.roles,
      this.enabled,
      this.authorities,
      this.username,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    isDeleted = json['isDeleted'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    telepon = json['telepon'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    enabled = json['enabled'];
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(Authorities.fromJson(v));
      });
    }
    username = json['username'];
    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    credentialsNonExpired = json['credentialsNonExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['isDeleted'] = isDeleted;
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['telepon'] = telepon;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['enabled'] = enabled;
    if (authorities != null) {
      data['authorities'] = authorities!.map((v) => v.toJson()).toList();
    }
    data['username'] = username;
    data['accountNonExpired'] = accountNonExpired;
    data['accountNonLocked'] = accountNonLocked;
    data['credentialsNonExpired'] = credentialsNonExpired;
    return data;
  }
}

class Roles {
  String? id;
  List<int>? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  bool? isDeleted;
  String? name;
  String? description;

  Roles(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.isDeleted,
      this.name,
      this.description});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'].cast<int>();
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    isDeleted = json['isDeleted'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['isDeleted'] = isDeleted;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class Authorities {
  String? authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authority'] = authority;
    return data;
  }
}