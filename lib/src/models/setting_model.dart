// To parse this JSON data, do
//
//     final resultSetting = resultSettingFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

ResultSetting resultSettingFromJson(String str) => ResultSetting.fromJson(json.decode(str));

String resultSettingToJson(ResultSetting data) => json.encode(data.toJson());

class ResultSetting {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Datum> data;

  ResultSetting({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
  });

  factory ResultSetting.fromJson(Map<String, dynamic> json) => ResultSetting(
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
  String nama;
  List<Page> page;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.nama,
    this.page,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    page: json["page"] == null ? null : List<Page>.from(json["page"].map((x) => Page.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nama": nama == null ? null : nama,
    "page": page == null ? null : List<dynamic>.from(page.map((x) => x.toJson())),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class Page {
  String id;
  String judul;
  DateTime createdAt;
  DateTime updatedAt;

  Page({
    this.id,
    this.judul,
    this.createdAt,
    this.updatedAt,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    id: json["id"] == null ? null : json["id"],
    judul: json["judul"] == null ? null : json["judul"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "judul": judul == null ? null : judul,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}


class SettingsDefault{
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  SettingsDefault({this.title, this.subtitle, this.onPressed});
}