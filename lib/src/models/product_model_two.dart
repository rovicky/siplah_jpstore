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
    error: json["Error"],
    pesanSys: json["Pesan_sys"],
    pesanUsr: json["Pesan_usr"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
    paging: Paging.fromJson(json["Paging"]),
  );

  Map<String, dynamic> toJson() => {
    "Error": error,
    "Pesan_sys": pesanSys,
    "Pesan_usr": pesanUsr,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    "Paging": paging.toJson(),
  };
}

class Datum {
  String id;
  String gambar;
  String nama;
  DateTime createdAt;
  DateTime updatedAt;
  List<Product> produk;

  Datum({
    this.id,
    this.gambar,
    this.nama,
    this.createdAt,
    this.updatedAt,
    this.produk,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    gambar: json["gambar"],
    nama: json["nama"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    produk: List<Product>.from(json["produk"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gambar": gambar,
    "nama": nama,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "produk": List<dynamic>.from(produk.map((x) => x.toJson())),
  };
}

class Product {
  String id;
  List<Foto> foto;
  String produk;
  String harga;
  List<dynamic> hargaZona;
  String userId;
  String userFoto;
  String userNama;
  String kabupatenId;
  String kabupatenNama;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    foto: List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
    produk: json["produk"],
    harga: json["harga"],
    hargaZona: json['harga_zona'],
    userId: json["user_id"],
    userFoto: json["user_foto"],
    userNama: json["user_nama"],
    kabupatenId: json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "foto": List<dynamic>.from(foto.map((x) => x.toJson())),
    "produk": produk,
    "harga": harga,
    "harga_zona": List<dynamic>.from(hargaZona.map((x) => x)),
    "user_id": userId,
    "user_foto": userFoto,
    "user_nama": userNama,
    "kabupaten_id": kabupatenId,
    "kabupaten_nama": kabupatenNama,
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
    id: json["id"],
    foto: json["foto"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "foto": foto,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}


class Paging {
  bool pagination;

  Paging({
    this.pagination,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    pagination: json["Pagination"],
  );

  Map<String, dynamic> toJson() => {
    "Pagination": pagination,
  };
}
