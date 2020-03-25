// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Datum> data;
  Paging paging;

  CartModel({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
    this.paging,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
  String penjualUserId;
  String foto;
  String nama;
  String kabupatenId;
  String kabupatenNama;
  List<Produk> produk;

  Datum({
    this.penjualUserId,
    this.foto,
    this.nama,
    this.kabupatenId,
    this.kabupatenNama,
    this.produk,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    penjualUserId: json["penjual_user_id"],
    foto: json["foto"],
    nama: json["nama"],
    kabupatenId: json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"],
    produk: List<Produk>.from(json["Produk"].map((x) => Produk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "penjual_user_id": penjualUserId,
    "foto": foto,
    "nama": nama,
    "kabupaten_id": kabupatenId,
    "kabupaten_nama": kabupatenNama,
    "Produk": List<dynamic>.from(produk.map((x) => x.toJson())),
  };
}

class Produk {
  String id;
  String penjualId;
  String penjualNama;
  String penjualKabupatenId;
  String penjualKabupatenNama;
  List<ProdukFoto> produkFoto;
  String produkId;
  String produkNama;
  String produkHarga;
  int subTotal;
  int produkOngkir;
  String kategoriId;
  String jumlah;
  dynamic catatan;
  DateTime createdAt;
  DateTime updatedAt;

  Produk({
    this.id,
    this.penjualId,
    this.penjualNama,
    this.penjualKabupatenId,
    this.penjualKabupatenNama,
    this.produkFoto,
    this.produkId,
    this.produkNama,
    this.produkHarga,
    this.subTotal,
    this.produkOngkir,
    this.kategoriId,
    this.jumlah,
    this.catatan,
    this.createdAt,
    this.updatedAt,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    id: json["id"],
    penjualId: json["penjual_id"],
    penjualNama: json["penjual_nama"],
    penjualKabupatenId: json["penjual_kabupaten_id"],
    penjualKabupatenNama: json["penjual_kabupaten_nama"],
    produkFoto: List<ProdukFoto>.from(json["produk_foto"].map((x) => ProdukFoto.fromJson(x))),
    produkId: json["produk_id"],
    produkNama: json["produk_nama"],
    produkHarga: json["produk_harga"],
    subTotal: json["sub_total"],
    produkOngkir: json["produk_ongkir"],
    kategoriId: json["kategori_id"],
    jumlah: json["jumlah"],
    catatan: json["catatan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "penjual_id": penjualId,
    "penjual_nama": penjualNama,
    "penjual_kabupaten_id": penjualKabupatenId,
    "penjual_kabupaten_nama": penjualKabupatenNama,
    "produk_foto": List<dynamic>.from(produkFoto.map((x) => x.toJson())),
    "produk_id": produkId,
    "produk_nama": produkNama,
    "produk_harga": produkHarga,
    "sub_total": subTotal,
    "produk_ongkir": produkOngkir,
    "kategori_id": kategoriId,
    "jumlah": jumlah,
    "catatan": catatan,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class ProdukFoto {
  String id;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;

  ProdukFoto({
    this.id,
    this.foto,
    this.createdAt,
    this.updatedAt,
  });

  factory ProdukFoto.fromJson(Map<String, dynamic> json) => ProdukFoto(
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
