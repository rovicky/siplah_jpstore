// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(String str) => ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
  String id;
  List<Foto> foto;
  String nama;
  String deskripsi;
  String dilihat;
  String terkirim;
  String sku;
  String kondisi;
  String stok;
  dynamic stokSlaluAda;
  String berat;
  String panjang;
  String lebar;
  String tinggi;
  String pembelianMinimum;
  String kelipatanPembelian;
  String hargaSatuan;
  List<HargaZona> hargaZona;
  String userId;
  String userFoto;
  String userNama;
  DateTime createdAt;
  DateTime updatedAt;

  ProductDetail({
    this.id,
    this.foto,
    this.nama,
    this.deskripsi,
    this.dilihat,
    this.terkirim,
    this.sku,
    this.kondisi,
    this.stok,
    this.stokSlaluAda,
    this.berat,
    this.panjang,
    this.lebar,
    this.tinggi,
    this.pembelianMinimum,
    this.kelipatanPembelian,
    this.hargaSatuan,
    this.hargaZona,
    this.userId,
    this.userFoto,
    this.userNama,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
    nama: json["nama"] == null ? null : json["nama"],
    deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
    dilihat: json["dilihat"] == null ? null : json["dilihat"],
    terkirim: json["terkirim"] == null ? null : json["terkirim"],
    sku: json["sku"] == null ? null : json["sku"],
    kondisi: json["kondisi"] == null ? null : json["kondisi"],
    stok: json["stok"] == null ? null : json["stok"],
    stokSlaluAda: json["stok_slalu_ada"],
    berat: json["berat"] == null ? null : json["berat"],
    panjang: json["panjang"] == null ? null : json["panjang"],
    lebar: json["lebar"] == null ? null : json["lebar"],
    tinggi: json["tinggi"] == null ? null : json["tinggi"],
    pembelianMinimum: json["pembelian_minimum"] == null ? null : json["pembelian_minimum"],
    kelipatanPembelian: json["kelipatan_pembelian"] == null ? null : json["kelipatan_pembelian"],
    hargaSatuan: json["harga_satuan"] == null ? null : json["harga_satuan"],
    hargaZona: json["harga_zona"] == null ? null : List<HargaZona>.from(json["harga_zona"].map((x) => HargaZona.fromJson(x))),
    userId: json["user_id"] == null ? null : json["user_id"],
    userFoto: json["user_foto"] == null ? null : json["user_foto"],
    userNama: json["user_nama"] == null ? null : json["user_nama"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto == null ? null : List<dynamic>.from(foto.map((x) => x.toJson())),
    "nama": nama == null ? null : nama,
    "deskripsi": deskripsi == null ? null : deskripsi,
    "dilihat": dilihat == null ? null : dilihat,
    "terkirim": terkirim == null ? null : terkirim,
    "sku": sku == null ? null : sku,
    "kondisi": kondisi == null ? null : kondisi,
    "stok": stok == null ? null : stok,
    "stok_slalu_ada": stokSlaluAda,
    "berat": berat == null ? null : berat,
    "panjang": panjang == null ? null : panjang,
    "lebar": lebar == null ? null : lebar,
    "tinggi": tinggi == null ? null : tinggi,
    "pembelian_minimum": pembelianMinimum == null ? null : pembelianMinimum,
    "kelipatan_pembelian": kelipatanPembelian == null ? null : kelipatanPembelian,
    "harga_satuan": hargaSatuan == null ? null : hargaSatuan,
    "harga_zona": hargaZona == null ? null : List<dynamic>.from(hargaZona.map((x) => x.toJson())),
    "user_id": userId == null ? null : userId,
    "user_foto": userFoto == null ? null : userFoto,
    "user_nama": userNama == null ? null : userNama,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
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
  String zonaNama;
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
    zonaNama: json["zona_nama"] == null ? null : json["zona_nama"],
    harga: json["harga"] == null ? null : json["harga"],
    provinsi: json["provinsi"] == null ? null : List<Provinsi>.from(json["provinsi"].map((x) => Provinsi.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "zona_id": zonaId == null ? null : zonaId,
    "zona_nama": zonaNama == null ? null : zonaNama,
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
