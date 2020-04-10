import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String id;
  dynamic foto;
  String npsn;
  String nama;
  String email;
  String provinsiId;
  String namaProvinsi;
  String kabupatenId;
  String namaKabupaten;
  String kecamatanId;
  String namaKecamatan;
  String alamat;
  String kodePos;
  String telepon;
  String levelId;
  String levelIdNama;
  String status;
  String createdAt;
  String updatedAt;

  UserData({
    this.id,
    this.foto,
    this.npsn,
    this.nama,
    this.email,
    this.provinsiId,
    this.namaProvinsi,
    this.kabupatenId,
    this.namaKabupaten,
    this.kecamatanId,
    this.namaKecamatan,
    this.alamat,
    this.kodePos,
    this.telepon,
    this.levelId,
    this.levelIdNama,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"] == null ? null : json["id"],
    foto: json["foto"],
    npsn: json["npsn"] == null ? null : json["npsn"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    provinsiId: json["provinsi_id"] == null ? null : json["provinsi_id"],
    namaProvinsi: json["provinsi_nama"] == null ? null : json["provinsi_nama"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    namaKabupaten: json["nama_kabupaten"] == null ? null : json["nama_kabupaten"],
    kecamatanId: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
    namaKecamatan: json["kecamatan_nama"] == null ? null : json["kecamatan_nama"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    kodePos: json["kode_pos"] == null ? null : json["kode_pos"],
    telepon: json["telepon"] == null ? null : json["telepon"],
    levelId: json["level_id"] == null ? null : json["level_id"],
    levelIdNama: json["level_id_nama"] == null ? null : json["level_id_nama"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json['created_at'].toString(),
    updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "foto": foto,
    "npsn": npsn == null ? null : npsn,
    "nama": nama == null ? null : nama,
    "email": email == null ? null : email,
    "provinsi_id": provinsiId == null ? null : provinsiId,
    "nama_provinsi": namaProvinsi == null ? null : namaProvinsi,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "nama_kabupaten": namaKabupaten == null ? null : namaKabupaten,
    "kecamatan_id": kecamatanId == null ? null : kecamatanId,
    "nama_kecamatan": namaKecamatan == null ? null : namaKecamatan,
    "alamat": alamat == null ? null : alamat,
    "kode_pos": kodePos == null ? null : kodePos,
    "telepon": telepon == null ? null : telepon,
    "level_id": levelId == null ? null : levelId,
    "level_id_nama": levelIdNama == null ? null : levelIdNama,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt
  };
}