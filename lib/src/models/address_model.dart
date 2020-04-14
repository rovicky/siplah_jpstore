// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  bool error;
  String message;
  List<Datum> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;

  AddressModel({
    this.error,
    this.message,
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
  String nama;
  String penerimaNama;
  String penerimaNoHp;
  String kodePos;
  String provinsiId;
  String provinsiNama;
  String kabupatenId;
  String kabupatenNama;
  String kecamatanId;
  String kecamatanNama;
  String alamat;
  String isUtama;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.nama,
    this.penerimaNama,
    this.penerimaNoHp,
    this.kodePos,
    this.provinsiId,
    this.provinsiNama,
    this.kabupatenId,
    this.kabupatenNama,
    this.kecamatanId,
    this.kecamatanNama,
    this.alamat,
    this.isUtama,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    penerimaNama: json["penerima_nama"] == null ? null : json["penerima_nama"],
    penerimaNoHp: json["penerima_no_hp"] == null ? null : json["penerima_no_hp"],
    kodePos: json["kode_pos"] == null ? null : json["kode_pos"],
    provinsiId: json["provinsi_id"] == null ? null : json["provinsi_id"],
    provinsiNama: json["provinsi_nama"] == null ? null : json["provinsi_nama"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"] == null ? null : json["kabupaten_nama"],
    kecamatanId: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
    kecamatanNama: json["kecamatan_nama"] == null ? null : json["kecamatan_nama"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    isUtama: json["is_utama"] == null ? null : json["is_utama"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nama": nama == null ? null : nama,
    "penerima_nama": penerimaNama == null ? null : penerimaNama,
    "penerima_no_hp": penerimaNoHp == null ? null : penerimaNoHp,
    "kode_pos": kodePos == null ? null : kodePos,
    "provinsi_id": provinsiId == null ? null : provinsiId,
    "provinsi_nama": provinsiNama == null ? null : provinsiNama,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "kabupaten_nama": kabupatenNama == null ? null : kabupatenNama,
    "kecamatan_id": kecamatanId == null ? null : kecamatanId,
    "kecamatan_nama": kecamatanNama == null ? null : kecamatanNama,
    "alamat": alamat == null ? null : alamat,
    "is_utama": isUtama == null ? null : isUtama,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
