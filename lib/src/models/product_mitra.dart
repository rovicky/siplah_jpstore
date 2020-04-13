// To parse this JSON data, do
//
//     final productMitra = productMitraFromJson(jsonString);

import 'dart:convert';

ProductMitra productMitraFromJson(String str) => ProductMitra.fromJson(json.decode(str));

String productMitraToJson(ProductMitra data) => json.encode(data.toJson());

class ProductMitra {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Products> data;
  Pagination pagination;

  ProductMitra({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
    this.pagination,
  });

  factory ProductMitra.fromJson(Map<String, dynamic> json) => ProductMitra(
    error: json["Error"] == null ? null : json["Error"],
    pesanSys: json["Pesan_sys"],
    pesanUsr: json["Pesan_usr"],
    data: json["Data"] == null ? null : List<Products>.from(json["Data"].map((x) => Products.fromJson(x))),
    pagination: json["Pagination"] == null ? null : Pagination.fromJson(json["Pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "Error": error == null ? null : error,
    "Pesan_sys": pesanSys,
    "Pesan_usr": pesanUsr,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "Pagination": pagination == null ? null : pagination.toJson(),
  };
}

class Products {
  String id;
  List<Foto> foto;
  String produk;
  String kategoriId;
  String harga;
  List<HargaZona> hargaZona;
  String userId;
  String userFoto;
  UserNama userNama;
  String kabupatenId;
  KabupatenNama kabupatenNama;

  Products({
    this.id,
    this.foto,
    this.produk,
    this.kategoriId,
    this.harga,
    this.hargaZona,
    this.userId,
    this.userFoto,
    this.userNama,
    this.kabupatenId,
    this.kabupatenNama,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
    produk: json["produk"] == null ? null : json["produk"],
    kategoriId: json["kategori_id"] == null ? null : json["kategori_id"],
    harga: json["harga"] == null ? null : json["harga"],
    hargaZona: json["harga_zona"] == null ? null : List<HargaZona>.from(json["harga_zona"].map((x) => HargaZona.fromJson(x))),
    userId: json["user_id"] == null ? null : json["user_id"],
    userFoto: json["user_foto"] == null ? null : json["user_foto"],
    userNama: json["user_nama"] == null ? null : userNamaValues.map[json["user_nama"]],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"] == null ? null : kabupatenNamaValues.map[json["kabupaten_nama"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto == null ? null : List<dynamic>.from(foto.map((x) => x.toJson())),
    "produk": produk == null ? null : produk,
    "kategori_id": kategoriId == null ? null : kategoriId,
    "harga": harga == null ? null : harga,
    "harga_zona": hargaZona == null ? null : List<dynamic>.from(hargaZona.map((x) => x.toJson())),
    "user_id": userId == null ? null : userId,
    "user_foto": userFoto == null ? null : userFoto,
    "user_nama": userNama == null ? null : userNamaValues.reverse[userNama],
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "kabupaten_nama": kabupatenNama == null ? null : kabupatenNamaValues.reverse[kabupatenNama],
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
  String id;
  String zonaId;
  ZonaNama zonaNama;
  String harga;
  List<Provinsi> provinsi;
  DateTime createdAt;
  DateTime updatedAt;

  HargaZona({
    this.id,
    this.zonaId,
    this.zonaNama,
    this.harga,
    this.provinsi,
    this.createdAt,
    this.updatedAt,
  });

  factory HargaZona.fromJson(Map<String, dynamic> json) => HargaZona(
    id: json["id"] == null ? null : json["id"],
    zonaId: json["zona_id"] == null ? null : json["zona_id"],
    zonaNama: json["zona_nama"] == null ? null : zonaNamaValues.map[json["zona_nama"]],
    harga: json["harga"] == null ? null : json["harga"],
    provinsi: json["provinsi"] == null ? null : List<Provinsi>.from(json["provinsi"].map((x) => Provinsi.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "zona_id": zonaId == null ? null : zonaId,
    "zona_nama": zonaNama == null ? null : zonaNamaValues.reverse[zonaNama],
    "harga": harga == null ? null : harga,
    "provinsi": provinsi == null ? null : List<dynamic>.from(provinsi.map((x) => x.toJson())),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class Provinsi {
  String id;
  String nama;

  Provinsi({
    this.id,
    this.nama,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nama": nama == null ? null : nama,
  };
}

enum ZonaNama { ZONA_1, ZONA_2, ZONA_3, ZONA_4, ZONA_5 }

final zonaNamaValues = EnumValues({
  "Zona 1": ZonaNama.ZONA_1,
  "Zona 2": ZonaNama.ZONA_2,
  "Zona 3": ZonaNama.ZONA_3,
  "Zona 4": ZonaNama.ZONA_4,
  "Zona 5": ZonaNama.ZONA_5
});

enum KabupatenNama { KOTA_DENPASAR }

final kabupatenNamaValues = EnumValues({
  "Kota Denpasar": KabupatenNama.KOTA_DENPASAR
});

enum UserNama { TEMPRINA_STORE_BALI }

final userNamaValues = EnumValues({
  "Temprina Store Bali": UserNama.TEMPRINA_STORE_BALI
});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
