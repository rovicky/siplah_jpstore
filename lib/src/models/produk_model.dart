// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  bool error;
  dynamic errorSys;
  dynamic errorUsr;
  List<Datum> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;

  Products({
    this.error,
    this.errorSys,
    this.errorUsr,
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    error: json["Error"] == null ? null : json["Error"],
    errorSys: json["Error_sys"],
    errorUsr: json["Error_usr"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
    draw: json["draw"],
    recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
    recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
  );

  Map<String, dynamic> toJson() => {
    "Error": error == null ? null : error,
    "Error_sys": errorSys,
    "Error_usr": errorUsr,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "draw": draw,
    "recordsTotal": recordsTotal == null ? null : recordsTotal,
    "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
  };
}

class Datum {
  String id;
  String produkId;
  String nama;
  String deskripsi;
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
  String skKementrian;
  String brandProduk;
  String kategoriId;
  String kategoriNama;
  String terbit;
  List<Foto> foto;
  List<Foto> kelas;
  List<Foto> jenjang;
  List<HargaZona> hargaZona;
  String createdAt;
  String updatedAt;

  Datum({
    this.id,
    this.produkId,
    this.nama,
    this.deskripsi,
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
    this.skKementrian,
    this.brandProduk,
    this.kategoriId,
    this.kategoriNama,
    this.terbit,
    this.foto,
    this.kelas,
    this.jenjang,
    this.hargaZona,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    produkId: json["produk_id"] == null ? null : json["produk_id"],
    nama: json["nama"] == null ? null : json["nama"],
    deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
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
    skKementrian: json["sk_kementrian"] == null ? null : json["sk_kementrian"],
    brandProduk: json["brand_produk"] == null ? null : json["brand_produk"],
    kategoriId: json["kategori_id"] == null ? null : json["kategori_id"],
    kategoriNama: json["kategori_nama"] == null ? null : json["kategori_nama"],
    terbit: json["terbit"] == null ? null : json["terbit"],
    foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
    kelas: json["kelas"] == null ? null : List<Foto>.from(json["kelas"].map((x) => Foto.fromJson(x))),
    jenjang: json["jenjang"] == null ? null : List<Foto>.from(json["jenjang"].map((x) => Foto.fromJson(x))),
    hargaZona: json["harga_zona"] == null ? null : List<HargaZona>.from(json["harga_zona"].map((x) => HargaZona.fromJson(x))),
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "produk_id": produkId == null ? null : produkId,
    "nama": nama == null ? null : nama,
    "deskripsi": deskripsi == null ? null : deskripsi,
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
    "sk_kementrian": skKementrian == null ? null : skKementrian,
    "brand_produk": brandProduk == null ? null : brandProduk,
    "kategori_id": kategoriId == null ? null : kategoriId,
    "kategori_nama": kategoriNama == null ? null : kategoriNama,
    "terbit": terbit == null ? null : terbit,
    "foto": foto == null ? null : List<dynamic>.from(foto.map((x) => x.toJson())),
    "kelas": kelas == null ? null : List<dynamic>.from(kelas.map((x) => x.toJson())),
    "jenjang": jenjang == null ? null : List<dynamic>.from(jenjang.map((x) => x.toJson())),
    "harga_zona": hargaZona == null ? null : List<dynamic>.from(hargaZona.map((x) => x.toJson())),
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}

class Foto {
  String id;
  String foto;
  String createdAt;
  String updatedAt;
  String jenjang;
  String kelas;

  Foto({
    this.id,
    this.foto,
    this.createdAt,
    this.updatedAt,
    this.jenjang,
    this.kelas,
  });

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"] == null ? null : json["foto"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    jenjang: json["jenjang"] == null ? null : json["jenjang"],
    kelas: json["kelas"] == null ? null : json["kelas"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto == null ? null : foto,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "jenjang": jenjang == null ? null : jenjang,
    "kelas": kelas == null ? null : kelas,
  };
}

class HargaZona {
  String id;
  String zonaId;
  String zonaNama;
  String harga;

  HargaZona({
    this.id,
    this.zonaId,
    this.zonaNama,
    this.harga,
  });

  factory HargaZona.fromJson(Map<String, dynamic> json) => HargaZona(
    id: json["id"] == null ? null : json["id"],
    zonaId: json["zona_id"] == null ? null : json["zona_id"],
    zonaNama: json["zona_nama"] == null ? null : json["zona_nama"],
    harga: json["harga"] == null ? null : json["harga"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "zona_id": zonaId == null ? null : zonaId,
    "zona_nama": zonaNama == null ? null : zonaNama,
    "harga": harga == null ? null : harga,
  };
}
