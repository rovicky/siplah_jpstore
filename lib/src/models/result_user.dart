// To parse this JSON data, do
//
//     final resultUser = resultUserFromJson(jsonString);

import 'dart:convert';

import 'package:siplah_jpmall/src/models/user.dart';

ResultUser resultUserFromJson(String str) => ResultUser.fromJson(json.decode(str));

//String resultUserToJson(ResultUser data) => json.encode(data.toJson());

class ResultUser {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  UserData data;
  Paging paging;

  ResultUser({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
    this.paging,
  });

  factory ResultUser.fromJson(Map<String, dynamic> json) => ResultUser(
    error: json["Error"] == null ? null : json["Error"],
    pesanSys: json["Pesan_sys"],
    pesanUsr: json["Pesan_usr"],
    data: json["Data"] == null ? null : UserData.fromJson(json["Data"][0]),
    paging: json["Paging"] == null ? null : Paging.fromJson(json["Paging"]),
  );

//  Map<String, dynamic> toJson() => {
//    "Error": error == null ? null : error,
//    "Pesan_sys": pesanSys,
//    "Pesan_usr": pesanUsr,
//    "Data": data == null ? null : UserData().fromJson(data.map((x) => x.toJson())),
//    "Paging": paging == null ? null : paging.toJson(),
//  };
}



class Paging {
  bool pagination;

  Paging({
    this.pagination,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    pagination: json["Pagination"] == null ? null : json["Pagination"],
  );

  Map<String, dynamic> toJson() => {
    "Pagination": pagination == null ? null : pagination,
  };
}
