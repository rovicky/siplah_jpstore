// To parse this JSON data, do
//
//     final marketingModel = marketingModelFromJson(jsonString);

import 'dart:convert';

MarketingModel marketingModelFromJson(String str) => MarketingModel.fromJson(json.decode(str));

String marketingModelToJson(MarketingModel data) => json.encode(data.toJson());

class MarketingModel {
  bool error;
  String message;
  List<Datum> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;

  MarketingModel({
    this.error,
    this.message,
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  factory MarketingModel.fromJson(Map<String, dynamic> json) => MarketingModel(
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    draw: json["draw"],
    recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
    recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "draw": draw,
    "recordsTotal": recordsTotal == null ? null : recordsTotal,
    "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
  };
}

class Datum {
  String id;
  String kode;
  String kategori;
  String foto;
  String nama;
  String noTelepon;
  String email;
  String npwp;
  String jenisKelamin;
  String provinsiId;
  String namaProvinsi;
  String kabupatenId;
  String namaKabupaten;
  String kecamatanId;
  String namaKecamatan;
  String alamat;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.kode,
    this.kategori,
    this.foto,
    this.nama,
    this.noTelepon,
    this.email,
    this.npwp,
    this.jenisKelamin,
    this.provinsiId,
    this.namaProvinsi,
    this.kabupatenId,
    this.namaKabupaten,
    this.kecamatanId,
    this.namaKecamatan,
    this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    kode: json["kode"] == null ? null : json["kode"],
    kategori: json["kategori"] == null ? null : json["kategori"],
    foto: json["foto"] == null ? null : json["foto"],
    nama: json["nama"] == null ? null : json["nama"],
    noTelepon: json["no_telepon"] == null ? null : json["no_telepon"],
    email: json["email"] == null ? null : json["email"],
    npwp: json["npwp"] == null ? null : json["npwp"],
    jenisKelamin: json["jenis_kelamin"] == null ? null : json["jenis_kelamin"],
    provinsiId: json["provinsi_id"] == null ? null : json["provinsi_id"],
    namaProvinsi: json["nama_provinsi"] == null ? null : json["nama_provinsi"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    namaKabupaten: json["nama_kabupaten"] == null ? null : json["nama_kabupaten"],
    kecamatanId: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
    namaKecamatan: json["nama_kecamatan"] == null ? null : json["nama_kecamatan"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "kode": kode == null ? null : kode,
    "kategori": kategori == null ? null : kategori,
    "foto": foto == null ? null : foto,
    "nama": nama == null ? null : nama,
    "no_telepon": noTelepon == null ? null : noTelepon,
    "email": email == null ? null : email,
    "npwp": npwp == null ? null : npwp,
    "jenis_kelamin": jenisKelamin == null ? null : jenisKelamin,
    "provinsi_id": provinsiId == null ? null : provinsiId,
    "nama_provinsi": namaProvinsi == null ? null : namaProvinsi,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "nama_kabupaten": namaKabupaten == null ? null : namaKabupaten,
    "kecamatan_id": kecamatanId == null ? null : kecamatanId,
    "nama_kecamatan": namaKecamatan == null ? null : namaKecamatan,
    "alamat": alamat == null ? null : alamat,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
