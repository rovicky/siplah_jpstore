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
    penjualUserId: json["penjual_user_id"] == null ? null : json["penjual_user_id"],
    foto: json["foto"] == null ? null : json["foto"],
    nama: json["nama"] == null ? null : json["nama"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"] == null ? null : json["kabupaten_nama"],
    produk: json["Produk"] == null ? null : List<Produk>.from(json["Produk"].map((x) => Produk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "penjual_user_id": penjualUserId == null ? null : penjualUserId,
    "foto": foto == null ? null : foto,
    "nama": nama == null ? null : nama,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "kabupaten_nama": kabupatenNama == null ? null : kabupatenNama,
    "Produk": produk == null ? null : List<dynamic>.from(produk.map((x) => x.toJson())),
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
    id: json["id"] == null ? null : json["id"],
    penjualId: json["penjual_id"] == null ? null : json["penjual_id"],
    penjualNama: json["penjual_nama"] == null ? null : json["penjual_nama"],
    penjualKabupatenId: json["penjual_kabupaten_id"] == null ? null : json["penjual_kabupaten_id"],
    penjualKabupatenNama: json["penjual_kabupaten_nama"] == null ? null : json["penjual_kabupaten_nama"],
    produkFoto: json["produk_foto"] == null ? null : List<ProdukFoto>.from(json["produk_foto"].map((x) => ProdukFoto.fromJson(x))),
    produkId: json["produk_id"] == null ? null : json["produk_id"],
    produkNama: json["produk_nama"] == null ? null : json["produk_nama"],
    produkHarga: json["produk_harga"] == null ? null : json["produk_harga"],
    subTotal: json["sub_total"] == null ? null : json["sub_total"],
    produkOngkir: json["produk_ongkir"] == null ? null : json["produk_ongkir"],
    kategoriId: json["kategori_id"] == null ? null : json["kategori_id"],
    jumlah: json["jumlah"] == null ? null : json["jumlah"],
    catatan: json["catatan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "penjual_id": penjualId == null ? null : penjualId,
    "penjual_nama": penjualNama == null ? null : penjualNama,
    "penjual_kabupaten_id": penjualKabupatenId == null ? null : penjualKabupatenId,
    "penjual_kabupaten_nama": penjualKabupatenNama == null ? null : penjualKabupatenNama,
    "produk_foto": produkFoto == null ? null : List<dynamic>.from(produkFoto.map((x) => x.toJson())),
    "produk_id": produkId == null ? null : produkId,
    "produk_nama": produkNama == null ? null : produkNama,
    "produk_harga": produkHarga == null ? null : produkHarga,
    "sub_total": subTotal == null ? null : subTotal,
    "produk_ongkir": produkOngkir == null ? null : produkOngkir,
    "kategori_id": kategoriId == null ? null : kategoriId,
    "jumlah": jumlah == null ? null : jumlah,
    "catatan": catatan,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
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
