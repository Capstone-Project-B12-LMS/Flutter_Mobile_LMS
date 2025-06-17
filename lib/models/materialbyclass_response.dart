class MaterialByClassResponse {
  bool? status;
  List<Data>? data;

  MaterialByClassResponse({this.status, this.data});

  MaterialByClassResponse.fromJson(Map<String, dynamic> json) {
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
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? createdBy;
  String? updatedBy;
  bool? isDeleted;
  String? title;
  String? content;
  String? topic;
  String? videoUrl;
  String? fileUrl;
  String? deadline;
  String? point;
  String? classCode;

  Data(
      {this.id,
      this.createdBy,
      this.updatedBy,
      this.isDeleted,
      this.title,
      this.content,
      this.topic,
      this.videoUrl,
      this.fileUrl,
      this.deadline,
      this.point,
      this.classCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    isDeleted = json['is_deleted'];
    title = json['title'];
    content = json['content'];
    topic = json['topic'];
    videoUrl = json['video_url'];
    fileUrl = json['file_url'];
    deadline = json['deadline'];
    point = json['point'];
    classCode = json['classCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['is_deleted'] = isDeleted;
    data['title'] = title;
    data['content'] = content;
    data['topic'] = topic;
    data['video_url'] = videoUrl;
    data['file_url'] = fileUrl;
    data['deadline'] = deadline;
    data['point'] = point;
    data['classCode'] = classCode;
    return data;
  }
}
