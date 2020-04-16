// To parse this JSON data, do
//
//     final slideModel = slideModelFromJson(jsonString);

import 'dart:convert';

SlideModel slideModelFromJson(String str) => SlideModel.fromJson(json.decode(str));

String slideModelToJson(SlideModel data) => json.encode(data.toJson());

class SlideModel {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Slide> data;
  Paging paging;

  SlideModel({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
    this.paging,
  });

  factory SlideModel.fromJson(Map<String, dynamic> json) => SlideModel(
    error: json["Error"] == null ? null : json["Error"],
    pesanSys: json["Pesan_sys"],
    pesanUsr: json["Pesan_usr"],
    data: json["Data"] == null ? null : List<Slide>.from(json["Data"].map((x) => Slide.fromJson(x))),
    paging: json["Paging"] == null ? null : Paging.fromJson(json["Paging"]),
  );

  Map<String, dynamic> toJson() => {
    "Error": error == null ? null : error,
    "Pesan_sys": pesanSys,
    "Pesan_usr": pesanUsr,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "Paging": paging == null ? null : paging.toJson(),
  };
}

class Slide {
  String id;
  String gambar;
  String link;
  DateTime createdAt;
  DateTime updatedAt;

  Slide({
    this.id,
    this.gambar,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  factory Slide.fromJson(Map<String, dynamic> json) => Slide(
    id: json["id"] == null ? null : json["id"],
    gambar: json["gambar"] == null ? null : json["gambar"],
    link: json["link"] == null ? null : json["link"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "gambar": gambar == null ? null : gambar,
    "link": link == null ? null : link,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
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
