// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  bool error;
  String pesanSys;
  String pesanUsr;
  List<Datum> data;
  List<KelaElement> kelas;
  Pagination pagination;

  SearchModel({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
    this.kelas,
    this.pagination,
  });
  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    error: json["Error"] == null ? null : json["Error"],
    pesanSys: json["Pesan_sys"] == null ? null : json["Pesan_sys"],
    pesanUsr: json["Pesan_usr"] == null ? null : json["Pesan_usr"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
    kelas: json["Kelas"] == null ? null : List<KelaElement>.from(json["Kelas"].map((x) => KelaElement.fromJson(x))),
    pagination: json["Pagination"] == null ? null : Pagination.fromJson(json["Pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "Error": error == null ? null : error,
    "Pesan_sys": pesanSys == null ? null : pesanSys,
    "Pesan_usr": pesanUsr == null ? null : pesanUsr,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "Kelas": kelas == null ? null : List<dynamic>.from(kelas.map((x) => x.toJson())),
    "Pagination": pagination == null ? null : pagination.toJson(),
  };
}

class Datum {
  String id;
  List<Foto> foto;
  List<Kela> kelas;
  String produk;
  String harga;
  List<dynamic> hargaZona;
  String kategoriId;
  String userId;
  String userFoto;
  String userNama;
  String kabupatenId;
  String kabupatenNama;

  Datum({
    this.id,
    this.foto,
    this.kelas,
    this.produk,
    this.harga,
    this.hargaZona,
    this.kategoriId,
    this.userId,
    this.userFoto,
    this.userNama,
    this.kabupatenId,
    this.kabupatenNama,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
    kelas: json["kelas"] == null ? null : List<Kela>.from(json["kelas"].map((x) => Kela.fromJson(x))),
    produk: json["produk"] == null ? null : json["produk"],
    harga: json["harga"] == null ? null : json["harga"],
    hargaZona: json["harga_zona"] == null ? null : List<dynamic>.from(json["harga_zona"].map((x) => x)),
    kategoriId: json["kategori_id"] == null ? null : json["kategori_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userFoto: json["user_foto"] == null ? null : json["user_foto"],
    userNama: json["user_nama"] == null ? null : json["user_nama"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"] == null ? null : json["kabupaten_nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto == null ? null : List<dynamic>.from(foto.map((x) => x.toJson())),
    "kelas": kelas == null ? null : List<dynamic>.from(kelas.map((x) => x.toJson())),
    "produk": produk == null ? null : produk,
    "harga": harga == null ? null : harga,
    "harga_zona": hargaZona == null ? null : List<dynamic>.from(hargaZona.map((x) => x)),
    "kategori_id": kategoriId == null ? null : kategoriId,
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

  Foto({
    this.id,
    this.foto,
  });

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"] == null ? null : json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto == null ? null : foto,
  };
}

class Kela {
  String id;
  String kelas;

  Kela({
    this.id,
    this.kelas,
  });

  factory Kela.fromJson(Map<String, dynamic> json) => Kela(
    id: json["id"] == null ? null : json["id"],
    kelas: json["kelas"] == null ? null : json["kelas"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "kelas": kelas == null ? null : kelas,
  };
}

class KelaElement {
  String kelas;

  KelaElement({
    this.kelas,
  });

  factory KelaElement.fromJson(Map<String, dynamic> json) => KelaElement(
    kelas: json["kelas"] == null ? null : json["kelas"],
  );

  Map<String, dynamic> toJson() => {
    "kelas": kelas == null ? null : kelas,
  };
}

class Pagination {
  bool pagination;
  String halaman;
  int dataKe;
  String jmlData;
  String jmlHalaman;
  String infoPaging;

  Pagination({
    this.pagination,
    this.halaman,
    this.dataKe,
    this.jmlData,
    this.jmlHalaman,
    this.infoPaging,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    pagination: json["Pagination"] == null ? null : json["Pagination"],
    halaman: json["Halaman"] == null ? null : json["Halaman"],
    dataKe: json["Data_ke"] == null ? null : json["Data_ke"],
    jmlData: json["Jml_data"] == null ? null : json["Jml_data"],
    jmlHalaman: json["Jml_halaman"] == null ? null : json["Jml_halaman"],
    infoPaging: json["Info_paging"] == null ? null : json["Info_paging"],
  );

  Map<String, dynamic> toJson() => {
    "Pagination": pagination == null ? null : pagination,
    "Halaman": halaman == null ? null : halaman,
    "Data_ke": dataKe == null ? null : dataKe,
    "Jml_data": jmlData == null ? null : jmlData,
    "Jml_halaman": jmlHalaman == null ? null : jmlHalaman,
    "Info_paging": infoPaging == null ? null : infoPaging,
  };
}
