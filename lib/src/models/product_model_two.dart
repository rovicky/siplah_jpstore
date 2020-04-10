// To parse this JSON data, do
//
//     final productModeltwo = productModeltwoFromJson(jsonString);

import 'dart:convert';

ProductModeltwo productModeltwoFromJson(String str) => ProductModeltwo.fromJson(json.decode(str));

String productModeltwoToJson(ProductModeltwo data) => json.encode(data.toJson());

class ProductModeltwo {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Datum> data;
  Paging paging;

  ProductModeltwo({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
    this.paging,
  });

  factory ProductModeltwo.fromJson(Map<String, dynamic> json) => ProductModeltwo(
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
  String nama;
  DateTime createdAt;
  DateTime updatedAt;
  int sub;
  List<Produk> produk;

  Datum({
    this.id,
    this.gambar,
    this.nama,
    this.createdAt,
    this.updatedAt,
    this.sub,
    this.produk,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    gambar: json["gambar"] == null ? null : json["gambar"],
    nama: json["nama"] == null ? null : json["nama"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    sub: json["sub"] == null ? null : json["sub"],
    produk: json["produk"] == null ? null : List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "gambar": gambar == null ? null : gambar,
    "nama": nama == null ? null : nama,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "sub": sub == null ? null : sub,
    "produk": produk == null ? null : List<dynamic>.from(produk.map((x) => x.toJson())),
  };
}

class Produk {
  String id;
  List<Foto> foto;
  String produk;
  String harga;
  List<HargaZona> hargaZona;
  String userId;
  String userFoto;
  String userNama;
  String kabupatenId;
  String kabupatenNama;

  Produk({
    this.id,
    this.foto,
    this.produk,
    this.harga,
    this.hargaZona,
    this.userId,
    this.userFoto,
    this.userNama,
    this.kabupatenId,
    this.kabupatenNama,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
    produk: json["produk"] == null ? null : json["produk"],
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
    "produk": produk == null ? null : produk,
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
  Nama nama;
  String harga;

  HargaZona({
    this.nama,
    this.harga,
  });

  factory HargaZona.fromJson(Map<String, dynamic> json) => HargaZona(
    nama: json["nama"] == null ? null : namaValues.map[json["nama"]],
    harga: json["harga"] == null ? null : json["harga"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama == null ? null : namaValues.reverse[nama],
    "harga": harga == null ? null : harga,
  };
}

enum Nama { ZONA_1, ZONA_2, ZONA_3, ZONA_4, ZONA_5 }

final namaValues = EnumValues({
  "Zona 1": Nama.ZONA_1,
  "Zona 2": Nama.ZONA_2,
  "Zona 3": Nama.ZONA_3,
  "Zona 4": Nama.ZONA_4,
  "Zona 5": Nama.ZONA_5
});

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
