// To parse this JSON data, do
//
//     final sekolahUser = sekolahUserFromJson(jsonString);

import 'dart:convert';

SekolahUser sekolahUserFromJson(String str) => SekolahUser.fromJson(json.decode(str));

String sekolahUserToJson(SekolahUser data) => json.encode(data.toJson());

class SekolahUser {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Datum> data;
  Paging paging;

  SekolahUser({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
    this.paging,
  });

  factory SekolahUser.fromJson(Map<String, dynamic> json) => SekolahUser(
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
  dynamic foto;
  dynamic sekolahLogo;
  String sekolahNama;
  String sekolahKepala;
  String npsn;
  String nama;
  String email;
  String provinsiId;
  String provinsiNama;
  String kabupatenId;
  String namaKabupaten;
  String kecamatanId;
  String kecamatanNama;
  String alamat;
  String kodePos;
  String telepon;
  String levelId;
  String levelIdNama;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.foto,
    this.sekolahLogo,
    this.sekolahNama,
    this.sekolahKepala,
    this.npsn,
    this.nama,
    this.email,
    this.provinsiId,
    this.provinsiNama,
    this.kabupatenId,
    this.namaKabupaten,
    this.kecamatanId,
    this.kecamatanNama,
    this.alamat,
    this.kodePos,
    this.telepon,
    this.levelId,
    this.levelIdNama,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"],
    sekolahLogo: json["sekolah_logo"],
    sekolahNama: json["sekolah_nama"] == null ? null : json["sekolah_nama"],
    sekolahKepala: json["sekolah_kepala"] == null ? null : json["sekolah_kepala"],
    npsn: json["npsn"] == null ? null : json["npsn"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    provinsiId: json["provinsi_id"] == null ? null : json["provinsi_id"],
    provinsiNama: json["provinsi_nama"] == null ? null : json["provinsi_nama"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    namaKabupaten: json["nama_kabupaten"] == null ? null : json["nama_kabupaten"],
    kecamatanId: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
    kecamatanNama: json["kecamatan_nama"] == null ? null : json["kecamatan_nama"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    kodePos: json["kode_pos"] == null ? null : json["kode_pos"],
    telepon: json["telepon"] == null ? null : json["telepon"],
    levelId: json["level_id"] == null ? null : json["level_id"],
    levelIdNama: json["level_id_nama"] == null ? null : json["level_id_nama"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto,
    "sekolah_logo": sekolahLogo,
    "sekolah_nama": sekolahNama == null ? null : sekolahNama,
    "sekolah_kepala": sekolahKepala == null ? null : sekolahKepala,
    "npsn": npsn == null ? null : npsn,
    "nama": nama == null ? null : nama,
    "email": email == null ? null : email,
    "provinsi_id": provinsiId == null ? null : provinsiId,
    "provinsi_nama": provinsiNama == null ? null : provinsiNama,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "nama_kabupaten": namaKabupaten == null ? null : namaKabupaten,
    "kecamatan_id": kecamatanId == null ? null : kecamatanId,
    "kecamatan_nama": kecamatanNama == null ? null : kecamatanNama,
    "alamat": alamat == null ? null : alamat,
    "kode_pos": kodePos == null ? null : kodePos,
    "telepon": telepon == null ? null : telepon,
    "level_id": levelId == null ? null : levelId,
    "level_id_nama": levelIdNama == null ? null : levelIdNama,
    "status": status == null ? null : status,
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
