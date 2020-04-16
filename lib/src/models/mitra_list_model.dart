// To parse this JSON data, do
//
//     final mitraListModel = mitraListModelFromJson(jsonString);

import 'dart:convert';

MitraListModel mitraListModelFromJson(String str) => MitraListModel.fromJson(json.decode(str));

String mitraListModelToJson(MitraListModel data) => json.encode(data.toJson());

class MitraListModel {
  bool error;
  String message;
  List<Datum> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;

  MitraListModel({
    this.error,
    this.message,
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  factory MitraListModel.fromJson(Map<String, dynamic> json) => MitraListModel(
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
  dynamic foto;
  String nama;
  dynamic namaPenanggungJawab;
  String email;
  String telepon;
  String provinsiId;
  String provinsiNama;
  String kabupatenId;
  String namaKabupaten;
  String kecamatanId;
  String kecamatanNama;
  String alamat;
  String type;
  String kodePos;
  String levelId;
  String levelNama;
  dynamic rekeningNamaPemilik;
  dynamic rekeningNo;
  dynamic bank;
  dynamic deskripsi;
  dynamic npwp;
  dynamic penandaTangan;
  dynamic penandaTanganPosisi;
  dynamic limitasiMinimum;
  dynamic latitude;
  dynamic longitude;
  dynamic dokumenAktaPerusahaan;
  dynamic dokumenNpwp;
  dynamic dokumenKtp;
  dynamic dokumenSiupTdp;
  dynamic dokumenSuratDomisili;
  dynamic dokumenLainnya;
  String isAktif;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.foto,
    this.nama,
    this.namaPenanggungJawab,
    this.email,
    this.telepon,
    this.provinsiId,
    this.provinsiNama,
    this.kabupatenId,
    this.namaKabupaten,
    this.kecamatanId,
    this.kecamatanNama,
    this.alamat,
    this.type,
    this.kodePos,
    this.levelId,
    this.levelNama,
    this.rekeningNamaPemilik,
    this.rekeningNo,
    this.bank,
    this.deskripsi,
    this.npwp,
    this.penandaTangan,
    this.penandaTanganPosisi,
    this.limitasiMinimum,
    this.latitude,
    this.longitude,
    this.dokumenAktaPerusahaan,
    this.dokumenNpwp,
    this.dokumenKtp,
    this.dokumenSiupTdp,
    this.dokumenSuratDomisili,
    this.dokumenLainnya,
    this.isAktif,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"],
    nama: json["nama"] == null ? null : json["nama"],
    namaPenanggungJawab: json["nama_penanggung_jawab"],
    email: json["email"] == null ? null : json["email"],
    telepon: json["telepon"] == null ? null : json["telepon"],
    provinsiId: json["provinsi_id"] == null ? null : json["provinsi_id"],
    provinsiNama: json["provinsi_nama"] == null ? null : json["provinsi_nama"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    namaKabupaten: json["nama_kabupaten"] == null ? null : json["nama_kabupaten"],
    kecamatanId: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
    kecamatanNama: json["kecamatan_nama"] == null ? null : json["kecamatan_nama"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    type: json["type"] == null ? null : json["type"],
    kodePos: json["kode_pos"] == null ? null : json["kode_pos"],
    levelId: json["level_id"] == null ? null : json["level_id"],
    levelNama: json["level_nama"] == null ? null : json["level_nama"],
    rekeningNamaPemilik: json["rekening_nama_pemilik"],
    rekeningNo: json["rekening_no"],
    bank: json["bank"],
    deskripsi: json["deskripsi"],
    npwp: json["npwp"],
    penandaTangan: json["penanda_tangan"],
    penandaTanganPosisi: json["penanda_tangan_posisi"],
    limitasiMinimum: json["limitasi_minimum"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    dokumenAktaPerusahaan: json["dokumen_akta_perusahaan"],
    dokumenNpwp: json["dokumen_npwp"],
    dokumenKtp: json["dokumen_ktp"],
    dokumenSiupTdp: json["dokumen_siup_tdp"],
    dokumenSuratDomisili: json["dokumen_surat_domisili"],
    dokumenLainnya: json["dokumen_lainnya"],
    isAktif: json["is_aktif"] == null ? null : json["is_aktif"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto,
    "nama": nama == null ? null : nama,
    "nama_penanggung_jawab": namaPenanggungJawab,
    "email": email == null ? null : email,
    "telepon": telepon == null ? null : telepon,
    "provinsi_id": provinsiId == null ? null : provinsiId,
    "provinsi_nama": provinsiNama == null ? null : provinsiNama,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "nama_kabupaten": namaKabupaten == null ? null : namaKabupaten,
    "kecamatan_id": kecamatanId == null ? null : kecamatanId,
    "kecamatan_nama": kecamatanNama == null ? null : kecamatanNama,
    "alamat": alamat == null ? null : alamat,
    "type": type == null ? null : type,
    "kode_pos": kodePos == null ? null : kodePos,
    "level_id": levelId == null ? null : levelId,
    "level_nama": levelNama == null ? null : levelNama,
    "rekening_nama_pemilik": rekeningNamaPemilik,
    "rekening_no": rekeningNo,
    "bank": bank,
    "deskripsi": deskripsi,
    "npwp": npwp,
    "penanda_tangan": penandaTangan,
    "penanda_tangan_posisi": penandaTanganPosisi,
    "limitasi_minimum": limitasiMinimum,
    "latitude": latitude,
    "longitude": longitude,
    "dokumen_akta_perusahaan": dokumenAktaPerusahaan,
    "dokumen_npwp": dokumenNpwp,
    "dokumen_ktp": dokumenKtp,
    "dokumen_siup_tdp": dokumenSiupTdp,
    "dokumen_surat_domisili": dokumenSuratDomisili,
    "dokumen_lainnya": dokumenLainnya,
    "is_aktif": isAktif == null ? null : isAktif,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
