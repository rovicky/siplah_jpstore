// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Datum> data;

  PaymentModel({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    error: json["Error"] == null ? null : json["Error"],
    pesanSys: json["Pesan_sys"],
    pesanUsr: json["Pesan_usr"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Error": error == null ? null : error,
    "Pesan_sys": pesanSys,
    "Pesan_usr": pesanUsr,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String mitraId;
  String foto;
  String nama;
  String kurir;
  String kurirId;
  int ongkir;
  String waktu;
  String kabupatenId;
  String kabupatenNama;
  String kecamatanId;
  String kecamatanNama;
  String asal;
  String asalNama;
  String tujuanId;
  String tujuanNama;
  String tujuanKecamatanId;
  String tujuanKecamatanNama;
  int totalBerat;
  String subTotalProduk;

  Datum({
    this.id,
    this.mitraId,
    this.foto,
    this.nama,
    this.kurir,
    this.kurirId,
    this.ongkir,
    this.waktu,
    this.kabupatenId,
    this.kabupatenNama,
    this.kecamatanId,
    this.kecamatanNama,
    this.asal,
    this.asalNama,
    this.tujuanId,
    this.tujuanNama,
    this.tujuanKecamatanId,
    this.tujuanKecamatanNama,
    this.totalBerat,
    this.subTotalProduk,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    mitraId: json["mitra_id"] == null ? null : json["mitra_id"],
    foto: json["foto"] == null ? null : json["foto"],
    nama: json["nama"] == null ? null : json["nama"],
    kurir: json["kurir"] == null ? null : json["kurir"],
    kurirId: json["kurir_id"] == null ? null : json["kurir_id"],
    ongkir: json["ongkir"] == null ? null : json["ongkir"],
    waktu: json["waktu"] == null ? null : json["waktu"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"] == null ? null : json["kabupaten_nama"],
    kecamatanId: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
    kecamatanNama: json["kecamatan_nama"] == null ? null : json["kecamatan_nama"],
    asal: json["asal"] == null ? null : json["asal"],
    asalNama: json["asal_nama"] == null ? null : json["asal_nama"],
    tujuanId: json["tujuan_id"] == null ? null : json["tujuan_id"],
    tujuanNama: json["tujuan_nama"] == null ? null : json["tujuan_nama"],
    tujuanKecamatanId: json["tujuan_kecamatan_id"] == null ? null : json["tujuan_kecamatan_id"],
    tujuanKecamatanNama: json["tujuan_kecamatan_nama"] == null ? null : json["tujuan_kecamatan_nama"],
    totalBerat: json["total_berat"] == null ? null : json["total_berat"],
    subTotalProduk: json["sub_total_produk"] == null ? null : json["sub_total_produk"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "mitra_id": mitraId == null ? null : mitraId,
    "foto": foto == null ? null : foto,
    "nama": nama == null ? null : nama,
    "kurir": kurir == null ? null : kurir,
    "kurir_id": kurirId == null ? null : kurirId,
    "ongkir": ongkir == null ? null : ongkir,
    "waktu": waktu == null ? null : waktu,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "kabupaten_nama": kabupatenNama == null ? null : kabupatenNama,
    "kecamatan_id": kecamatanId == null ? null : kecamatanId,
    "kecamatan_nama": kecamatanNama == null ? null : kecamatanNama,
    "asal": asal == null ? null : asal,
    "asal_nama": asalNama == null ? null : asalNama,
    "tujuan_id": tujuanId == null ? null : tujuanId,
    "tujuan_nama": tujuanNama == null ? null : tujuanNama,
    "tujuan_kecamatan_id": tujuanKecamatanId == null ? null : tujuanKecamatanId,
    "tujuan_kecamatan_nama": tujuanKecamatanNama == null ? null : tujuanKecamatanNama,
    "total_berat": totalBerat == null ? null : totalBerat,
    "sub_total_produk": subTotalProduk == null ? null : subTotalProduk,
  };
}
