class ResponseRegister {
  String? errors;
  Data? data;

  ResponseRegister({this.errors, this.data});

  ResponseRegister.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  List<int>? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  bool? isDeleted;
  String? fullName;
  String? email;
  String? password;
  List<Roles>? roles;
  bool? enabled;
  List<Authorities>? authorities;
  String? username;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? credentialsNonExpired;

  Data(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.isDeleted,
      this.fullName,
      this.email,
      this.password,
      this.roles,
      this.enabled,
      this.authorities,
      this.username,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'].cast<int>();
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    isDeleted = json['isDeleted'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
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
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['isDeleted'] = isDeleted;
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
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
