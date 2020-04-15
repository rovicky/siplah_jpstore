// To parse this JSON data, do
//
//     final settingDetail = settingDetailFromJson(jsonString);

import 'dart:convert';

SettingDetail settingDetailFromJson(String str) => SettingDetail.fromJson(json.decode(str));

String settingDetailToJson(SettingDetail data) => json.encode(data.toJson());

class SettingDetail {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Datum> data;

  SettingDetail({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
  });

  factory SettingDetail.fromJson(Map<String, dynamic> json) => SettingDetail(
    error: json["Error"] == null ? null : json["Error"],
    pesanSys: json["Pesan_sys"],
    pesanUsr: json["Pesan_usr"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Error": error == null ? null : error,
    "Pesan_sys": pesanSys,
    "Pesan_usr": pesanUsr,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String blogId;
  dynamic gambar;
  String judul;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.blogId,
    this.gambar,
    this.judul,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    blogId: json["blog_id"] == null ? null : json["blog_id"],
    gambar: json["gambar"],
    judul: json["judul"] == null ? null : json["judul"],
    content: json["content"] == null ? null : json["content"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "blog_id": blogId == null ? null : blogId,
    "gambar": gambar,
    "judul": judul == null ? null : judul,
    "content": content == null ? null : content,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
