// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    bool error;
    dynamic pesanSys;
    dynamic pesanUsr;
    List<Datum> data;
    Paging paging;

    CategoryModel({
        this.error,
        this.pesanSys,
        this.pesanUsr,
        this.data,
        this.paging,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        error: json["Error"] == null ? null : json["Error"],
        pesanSys: json["Pesan_sys"],
        pesanUsr: json["Pesan_usr"],
        data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
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

class Datum {
    String id;
    String gambar;
    String icon;
    String nama;
    String hargaZona;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        this.id,
        this.gambar,
        this.icon,
        this.nama,
        this.hargaZona,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        gambar: json["gambar"] == null ? null : json["gambar"],
        icon: json["icon"] == null ? null : json["icon"],
        nama: json["nama"] == null ? null : json["nama"],
        hargaZona: json["harga_zona"] == null ? null : json["harga_zona"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "gambar": gambar == null ? null : gambar,
        "icon": icon == null ? null : icon,
        "nama": nama == null ? null : nama,
        "harga_zona": hargaZona == null ? null : hargaZona,
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
