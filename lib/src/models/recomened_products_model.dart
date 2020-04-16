// To parse this JSON data, do
//
//     final recomendedProducts = recomendedProductsFromJson(jsonString);

import 'dart:convert';

RecomendedProducts recomendedProductsFromJson(String str) => RecomendedProducts.fromJson(json.decode(str));

String recomendedProductsToJson(RecomendedProducts data) => json.encode(data.toJson());

class RecomendedProducts {
  bool error;
  dynamic message;
  List<RcData> data;
  Pagination pagination;

  RecomendedProducts({
    this.error,
    this.message,
    this.data,
    this.pagination,
  });

  factory RecomendedProducts.fromJson(Map<String, dynamic> json) => RecomendedProducts(
    error: json["Error"] == null ? null : json["Error"],
    message: json["Message"],
    data: json["Data"] == null ? null : List<RcData>.from(json["Data"].map((x) => RcData.fromJson(x))),
    pagination: json["Pagination"] == null ? null : Pagination.fromJson(json["Pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "Error": error == null ? null : error,
    "Message": message,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "Pagination": pagination == null ? null : pagination.toJson(),
  };
}

class RcData {
  String id;
  List<Foto> foto;
  String namaProduk;
  String kategoriId;
  String harga;
  List<HargaZona> hargaZona;
  String userId;
  String userFoto;
  String userNama;
  String kabupatenId;
  String kabupatenNama;

  RcData({
    this.id,
    this.foto,
    this.namaProduk,
    this.kategoriId,
    this.harga,
    this.hargaZona,
    this.userId,
    this.userFoto,
    this.userNama,
    this.kabupatenId,
    this.kabupatenNama,
  });

  factory RcData.fromJson(Map<String, dynamic> json) => RcData(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
    namaProduk: json["nama_produk"] == null ? null : json["nama_produk"],
    kategoriId: json["kategori_id"] == null ? null : json["kategori_id"],
    harga: json["harga"] == null ? null : json["harga"],
    hargaZona: json["harga_zona"] == null ? null : List<HargaZona>.from(json["harga_zona"].map((x) => HargaZona.fromJson(x))),
    userId: json["user_id"] == null ? null : json["user_id"],
    userFoto: json["user_foto"] == null ? null : json["user_foto"],
    userNama: json["user_nama"] == null ? null : json["user_nama"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"] == null ? null : json["kabupaten_nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto == null ? null : List<dynamic>.from(foto.map((x) => x.toJson())),
    "nama_produk": namaProduk == null ? null : namaProduk,
    "kategori_id": kategoriId == null ? null : kategoriId,
    "harga": harga == null ? null : harga,
    "harga_zona": hargaZona == null ? null : List<dynamic>.from(hargaZona.map((x) => x.toJson())),
    "user_id": userId == null ? null : userId,
    "user_foto": userFoto == null ? null : userFoto,
    "user_nama": userNama == null ? null : userNama,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "kabupaten_nama": kabupatenNama == null ? null : kabupatenNama,
  };
}

class Foto {
  String id;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;

  Foto({
    this.id,
    this.foto,
    this.createdAt,
    this.updatedAt,
  });

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"] == null ? null : json["foto"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto == null ? null : foto,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class HargaZona {
  String nama;
  String harga;

  HargaZona({
    this.nama,
    this.harga,
  });

  factory HargaZona.fromJson(Map<String, dynamic> json) => HargaZona(
    nama: json["nama"] == null ? null : json["nama"],
    harga: json["harga"] == null ? null : json["harga"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama == null ? null : nama,
    "harga": harga == null ? null : harga,
  };
}

class Pagination {
  bool status;
  int halaman;
  int limit;
  int dataKe;
  String jmlData;
  String jmlHalaman;
  String infoPaging;

  Pagination({
    this.status,
    this.halaman,
    this.limit,
    this.dataKe,
    this.jmlData,
    this.jmlHalaman,
    this.infoPaging,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    status: json["Status"] == null ? null : json["Status"],
    halaman: json["Halaman"] == null ? null : int.parse(json["Halaman"]),
    limit: json["Limit"] == null ? null : json["Limit"],
    dataKe: json["Data_ke"] == null ? null : json["Data_ke"],
    jmlData: json["Jml_data"] == null ? null : json["Jml_data"],
    jmlHalaman: json["Jml_halaman"] == null ? null : json["Jml_halaman"],
    infoPaging: json["Info_paging"] == null ? null : json["Info_paging"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Halaman": halaman == null ? null : halaman,
    "Limit": limit == null ? null : limit,
    "Data_ke": dataKe == null ? null : dataKe,
    "Jml_data": jmlData == null ? null : jmlData,
    "Jml_halaman": jmlHalaman == null ? null : jmlHalaman,
    "Info_paging": infoPaging == null ? null : infoPaging,
  };
}
