// To parse this JSON data, do
//
//     final cabangModel = cabangModelFromJson(jsonString);

import 'dart:convert';

CabangModel cabangModelFromJson(String str) => CabangModel.fromJson(json.decode(str));

String cabangModelToJson(CabangModel data) => json.encode(data.toJson());

class CabangModel {
    bool error;
    String message;
    List<Cabang> data;
    dynamic draw;
    int recordsTotal;
    int recordsFiltered;

    CabangModel({
        this.error,
        this.message,
        this.data,
        this.draw,
        this.recordsTotal,
        this.recordsFiltered,
    });

    factory CabangModel.fromJson(Map<String, dynamic> json) => CabangModel(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Cabang>.from(json["data"].map((x) => Cabang.fromJson(x))),
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

class Cabang {
  String cabangUserId;
    String id;
    dynamic foto;
    String nama;
    String namaPenanggungJawab;
    String email;
    String telepon;
    String password;
    String konfirmasiPassword;
    String provinsiId;
    String namaProvinsi;
    String kabupatenId;
    String namaKabupaten;
    String kecamatanId;
    String namaKecamatan;
    String alamat;
    dynamic kodePos;

    Cabang({
      this.cabangUserId,
        this.id,
        this.foto,
        this.nama,
        this.namaPenanggungJawab,
        this.email,
        this.telepon,
        this.password,
        this.konfirmasiPassword,
        this.provinsiId,
        this.namaProvinsi,
        this.kabupatenId,
        this.namaKabupaten,
        this.kecamatanId,
        this.namaKecamatan,
        this.alamat,
        this.kodePos,
    });

    factory Cabang.fromJson(Map<String, dynamic> json) => Cabang(
      cabangUserId: json['cabang_user_id'],
        id: json["id"] == null ? null : json["id"],
        foto: json["foto"],
        nama: json["nama"] == null ? null : json["nama"],
        namaPenanggungJawab: json["nama_penanggung_jawab"] == null ? null : json["nama_penanggung_jawab"],
        email: json["email"] == null ? null : json["email"],
        telepon: json["telepon"] == null ? null : json["telepon"],
        provinsiId: json["provinsi_id"] == null ? null : json["provinsi_id"],
        namaProvinsi: json["nama_provinsi"] == null ? null : json["nama_provinsi"],
        kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
        namaKabupaten: json["nama_kabupaten"] == null ? null : json["nama_kabupaten"],
        kecamatanId: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
        namaKecamatan: json["nama_kecamatan"] == null ? null : json["nama_kecamatan"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        kodePos: json["kode_pos"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cabang_user_id":cabangUserId,
        "foto": foto,
        "nama": nama == null ? null : nama,
        "nama_penanggung_jawab": namaPenanggungJawab == null ? null : namaPenanggungJawab,
        "email": email == null ? null : email,
        "telepon": telepon == null ? null : telepon,
        "password": password ?? null,
        "password_konfirmasi": konfirmasiPassword ?? null,
        "provinsi_id": provinsiId == null ? null : provinsiId,
        "kabupaten_id": kabupatenId == null ? null : kabupatenId,
        "kecamatan_id": kecamatanId == null ? null : kecamatanId,
        "alamat": alamat == null ? null : alamat,
        "kode_pos": kodePos,
    };
}
