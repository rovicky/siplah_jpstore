// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  bool error;
  dynamic pesanSys;
  dynamic pesanUsr;
  List<Datum> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;

  OrderModel({
    this.error,
    this.pesanSys,
    this.pesanUsr,
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    error: json["Error"] == null ? null : json["Error"],
    pesanSys: json["Pesan_sys"],
    pesanUsr: json["Pesan_usr"],
    data: json["Data"] == null ? null : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
    draw: json["draw"],
    recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
    recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
  );

  Map<String, dynamic> toJson() => {
    "Error": error == null ? null : error,
    "Pesan_sys": pesanSys,
    "Pesan_usr": pesanUsr,
    "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "draw": draw,
    "recordsTotal": recordsTotal == null ? null : recordsTotal,
    "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
  };
}

class Datum {
  String id;
  String total;
  DateTime tanggal;
  String status;
  String statusNama;
  List<Mitra> mitra;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.total,
    this.tanggal,
    this.status,
    this.statusNama,
    this.mitra,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    total: json["total"] == null ? null : json["total"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    status: json["status"] == null ? null : json["status"],
    statusNama: json["status_nama"] == null ? null : json["status_nama"],
    mitra: json["mitra"] == null ? null : List<Mitra>.from(json["mitra"].map((x) => Mitra.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "total": total == null ? null : total,
    "tanggal": tanggal == null ? null : tanggal.toIso8601String(),
    "status": status == null ? null : status,
    "status_nama": statusNama == null ? null : statusNama,
    "mitra": mitra == null ? null : List<dynamic>.from(mitra.map((x) => x.toJson())),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class Mitra {
  String id;
  String orderId;
  dynamic pembayaranType;
  dynamic pembayaranMelalui;
  String mitraId;
  String foto;
  String nama;
  String alamat;
  String telepon;
  String kabupatenId;
  String kabupatenNama;
  String rekeningNamaPemilik;
  String rekeningNo;
  String rekeningBank;
  String marketingId;
  dynamic marketingKode;
  dynamic marketingNama;
  String noInvoice;
  String purchaseOrder;
  String sekolahId;
  String sekolahFoto;
  String sekolahNama;
  String sekolahAlamat;
  dynamic noResi;
  String status;
  String statusNama;
  dynamic logDitolak;
  dynamic logDiproses;
  dynamic logDikirim;
  dynamic logDiterima;
  dynamic logDibayar;
  dynamic alasanDitolak;
  String alamatPengirimanId;
  String alamatPengirimanNama;
  String alamatPengirimanNamaPenerima;
  String alamatPengirimanTelepon;
  String alamatPengirimanKodePos;
  String alamatPengirimanProvinsiId;
  String alamatPengirimanProvinsiNama;
  String alamatPengirimanKabupatenId;
  String alamatPengirimanKabupatenNama;
  String alamatPengirimanKecamatanId;
  String alamatPengirimanKecamatanNama;
  String alamatPengirimanAlamat;
  String kurir;
  dynamic kurirKode;
  dynamic kurirService;
  dynamic kurirServiceDeskripsi;
  String dataKurirId;
  String dataKurirNama;
  String kurirOngkir;
  String estimasi;
  dynamic pembayaranCreate;
  dynamic pembayaranExpired;
  Files files;
  DateTime createdAt;
  DateTime updatedAt;
  List<Produk> produk;

  Mitra({
    this.id,
    this.orderId,
    this.pembayaranType,
    this.pembayaranMelalui,
    this.mitraId,
    this.foto,
    this.nama,
    this.alamat,
    this.telepon,
    this.kabupatenId,
    this.kabupatenNama,
    this.rekeningNamaPemilik,
    this.rekeningNo,
    this.rekeningBank,
    this.marketingId,
    this.marketingKode,
    this.marketingNama,
    this.noInvoice,
    this.purchaseOrder,
    this.sekolahId,
    this.sekolahFoto,
    this.sekolahNama,
    this.sekolahAlamat,
    this.noResi,
    this.status,
    this.statusNama,
    this.logDitolak,
    this.logDiproses,
    this.logDikirim,
    this.logDiterima,
    this.logDibayar,
    this.alasanDitolak,
    this.alamatPengirimanId,
    this.alamatPengirimanNama,
    this.alamatPengirimanNamaPenerima,
    this.alamatPengirimanTelepon,
    this.alamatPengirimanKodePos,
    this.alamatPengirimanProvinsiId,
    this.alamatPengirimanProvinsiNama,
    this.alamatPengirimanKabupatenId,
    this.alamatPengirimanKabupatenNama,
    this.alamatPengirimanKecamatanId,
    this.alamatPengirimanKecamatanNama,
    this.alamatPengirimanAlamat,
    this.kurir,
    this.kurirKode,
    this.kurirService,
    this.kurirServiceDeskripsi,
    this.dataKurirId,
    this.dataKurirNama,
    this.kurirOngkir,
    this.estimasi,
    this.pembayaranCreate,
    this.pembayaranExpired,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.produk,
  });

  factory Mitra.fromJson(Map<String, dynamic> json) => Mitra(
    id: json["id"] == null ? null : json["id"],
    orderId: json["order_id"] == null ? null : json["order_id"],
    pembayaranType: json["pembayaran_type"],
    pembayaranMelalui: json["pembayaran_melalui"],
    mitraId: json["mitra_id"] == null ? null : json["mitra_id"],
    foto: json["foto"] == null ? null : json["foto"],
    nama: json["nama"] == null ? null : json["nama"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    telepon: json["telepon"] == null ? null : json["telepon"],
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    kabupatenNama: json["kabupaten_nama"] == null ? null : json["kabupaten_nama"],
    rekeningNamaPemilik: json["rekening_nama_pemilik"] == null ? null : json["rekening_nama_pemilik"],
    rekeningNo: json["rekening_no"] == null ? null : json["rekening_no"],
    rekeningBank: json["rekening_bank"] == null ? null : json["rekening_bank"],
    marketingId: json["marketing_id"] == null ? null : json["marketing_id"],
    marketingKode: json["marketing_kode"],
    marketingNama: json["marketing_nama"],
    noInvoice: json["no_invoice"] == null ? null : json["no_invoice"],
    purchaseOrder: json["purchase_order"] == null ? null : json["purchase_order"],
    sekolahId: json["sekolah_id"] == null ? null : json["sekolah_id"],
    sekolahFoto: json["sekolah_foto"] == null ? null : json["sekolah_foto"],
    sekolahNama: json["sekolah_nama"] == null ? null : json["sekolah_nama"],
    sekolahAlamat: json["sekolah_alamat"] == null ? null : json["sekolah_alamat"],
    noResi: json["no_resi"],
    status: json["status"] == null ? null : json["status"],
    statusNama: json["status_nama"] == null ? null : json["status_nama"],
    logDitolak: json["log_ditolak"],
    logDiproses: json["log_diproses"],
    logDikirim: json["log_dikirim"],
    logDiterima: json["log_diterima"],
    logDibayar: json["log_dibayar"],
    alasanDitolak: json["alasan_ditolak"],
    alamatPengirimanId: json["alamat_pengiriman_id"] == null ? null : json["alamat_pengiriman_id"],
    alamatPengirimanNama: json["alamat_pengiriman_nama"] == null ? null : json["alamat_pengiriman_nama"],
    alamatPengirimanNamaPenerima: json["alamat_pengiriman_nama_penerima"] == null ? null : json["alamat_pengiriman_nama_penerima"],
    alamatPengirimanTelepon: json["alamat_pengiriman_telepon"] == null ? null : json["alamat_pengiriman_telepon"],
    alamatPengirimanKodePos: json["alamat_pengiriman_kode_pos"] == null ? null : json["alamat_pengiriman_kode_pos"],
    alamatPengirimanProvinsiId: json["alamat_pengiriman_provinsi_id"] == null ? null : json["alamat_pengiriman_provinsi_id"],
    alamatPengirimanProvinsiNama: json["alamat_pengiriman_provinsi_nama"] == null ? null : json["alamat_pengiriman_provinsi_nama"],
    alamatPengirimanKabupatenId: json["alamat_pengiriman_kabupaten_id"] == null ? null : json["alamat_pengiriman_kabupaten_id"],
    alamatPengirimanKabupatenNama: json["alamat_pengiriman_kabupaten_nama"] == null ? null : json["alamat_pengiriman_kabupaten_nama"],
    alamatPengirimanKecamatanId: json["alamat_pengiriman_kecamatan_id"] == null ? null : json["alamat_pengiriman_kecamatan_id"],
    alamatPengirimanKecamatanNama: json["alamat_pengiriman_kecamatan_nama"] == null ? null : json["alamat_pengiriman_kecamatan_nama"],
    alamatPengirimanAlamat: json["alamat_pengiriman_alamat"] == null ? null : json["alamat_pengiriman_alamat"],
    kurir: json["kurir"] == null ? null : json["kurir"],
    kurirKode: json["kurir_kode"],
    kurirService: json["kurir_service"],
    kurirServiceDeskripsi: json["kurir_service_deskripsi"],
    dataKurirId: json["data_kurir_id"] == null ? null : json["data_kurir_id"],
    dataKurirNama: json["data_kurir_nama"] == null ? null : json["data_kurir_nama"],
    kurirOngkir: json["kurir_ongkir"] == null ? null : json["kurir_ongkir"],
    estimasi: json["estimasi"] == null ? null : json["estimasi"],
    pembayaranCreate: json["pembayaran_create"],
    pembayaranExpired: json["pembayaran_expired"],
    files: json["files"] == null ? null : Files.fromJson(json["files"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    produk: json["produk"] == null ? null : List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "order_id": orderId == null ? null : orderId,
    "pembayaran_type": pembayaranType,
    "pembayaran_melalui": pembayaranMelalui,
    "mitra_id": mitraId == null ? null : mitraId,
    "foto": foto == null ? null : foto,
    "nama": nama == null ? null : nama,
    "alamat": alamat == null ? null : alamat,
    "telepon": telepon == null ? null : telepon,
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "kabupaten_nama": kabupatenNama == null ? null : kabupatenNama,
    "rekening_nama_pemilik": rekeningNamaPemilik == null ? null : rekeningNamaPemilik,
    "rekening_no": rekeningNo == null ? null : rekeningNo,
    "rekening_bank": rekeningBank == null ? null : rekeningBank,
    "marketing_id": marketingId == null ? null : marketingId,
    "marketing_kode": marketingKode,
    "marketing_nama": marketingNama,
    "no_invoice": noInvoice == null ? null : noInvoice,
    "purchase_order": purchaseOrder == null ? null : purchaseOrder,
    "sekolah_id": sekolahId == null ? null : sekolahId,
    "sekolah_foto": sekolahFoto == null ? null : sekolahFoto,
    "sekolah_nama": sekolahNama == null ? null : sekolahNama,
    "sekolah_alamat": sekolahAlamat == null ? null : sekolahAlamat,
    "no_resi": noResi,
    "status": status == null ? null : status,
    "status_nama": statusNama == null ? null : statusNama,
    "log_ditolak": logDitolak,
    "log_diproses": logDiproses,
    "log_dikirim": logDikirim,
    "log_diterima": logDiterima,
    "log_dibayar": logDibayar,
    "alasan_ditolak": alasanDitolak,
    "alamat_pengiriman_id": alamatPengirimanId == null ? null : alamatPengirimanId,
    "alamat_pengiriman_nama": alamatPengirimanNama == null ? null : alamatPengirimanNama,
    "alamat_pengiriman_nama_penerima": alamatPengirimanNamaPenerima == null ? null : alamatPengirimanNamaPenerima,
    "alamat_pengiriman_telepon": alamatPengirimanTelepon == null ? null : alamatPengirimanTelepon,
    "alamat_pengiriman_kode_pos": alamatPengirimanKodePos == null ? null : alamatPengirimanKodePos,
    "alamat_pengiriman_provinsi_id": alamatPengirimanProvinsiId == null ? null : alamatPengirimanProvinsiId,
    "alamat_pengiriman_provinsi_nama": alamatPengirimanProvinsiNama == null ? null : alamatPengirimanProvinsiNama,
    "alamat_pengiriman_kabupaten_id": alamatPengirimanKabupatenId == null ? null : alamatPengirimanKabupatenId,
    "alamat_pengiriman_kabupaten_nama": alamatPengirimanKabupatenNama == null ? null : alamatPengirimanKabupatenNama,
    "alamat_pengiriman_kecamatan_id": alamatPengirimanKecamatanId == null ? null : alamatPengirimanKecamatanId,
    "alamat_pengiriman_kecamatan_nama": alamatPengirimanKecamatanNama == null ? null : alamatPengirimanKecamatanNama,
    "alamat_pengiriman_alamat": alamatPengirimanAlamat == null ? null : alamatPengirimanAlamat,
    "kurir": kurir == null ? null : kurir,
    "kurir_kode": kurirKode,
    "kurir_service": kurirService,
    "kurir_service_deskripsi": kurirServiceDeskripsi,
    "data_kurir_id": dataKurirId == null ? null : dataKurirId,
    "data_kurir_nama": dataKurirNama == null ? null : dataKurirNama,
    "kurir_ongkir": kurirOngkir == null ? null : kurirOngkir,
    "estimasi": estimasi == null ? null : estimasi,
    "pembayaran_create": pembayaranCreate,
    "pembayaran_expired": pembayaranExpired,
    "files": files == null ? null : files.toJson(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "produk": produk == null ? null : List<dynamic>.from(produk.map((x) => x.toJson())),
  };
}

class Files {
  dynamic bast;
  dynamic buktiPembayaran;

  Files({
    this.bast,
    this.buktiPembayaran,
  });

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    bast: json["BAST"],
    buktiPembayaran: json["Bukti_pembayaran"],
  );

  Map<String, dynamic> toJson() => {
    "BAST": bast,
    "Bukti_pembayaran": buktiPembayaran,
  };
}

class Produk {
  String id;
  String transaksiId;
  String produkId;
  String foto;
  String nama;
  String deskripsi;
  String berat;
  String panjang;
  String lebar;
  String tinggi;
  String brandProduk;
  String harga;
  String jumlah;
  String catatan;
  String gratisOngkir;
  String hargaZona;
  String nego;
  int negoJumlah;
  DateTime createdAt;
  DateTime updatedAt;

  Produk({
    this.id,
    this.transaksiId,
    this.produkId,
    this.foto,
    this.nama,
    this.deskripsi,
    this.berat,
    this.panjang,
    this.lebar,
    this.tinggi,
    this.brandProduk,
    this.harga,
    this.jumlah,
    this.catatan,
    this.gratisOngkir,
    this.hargaZona,
    this.nego,
    this.negoJumlah,
    this.createdAt,
    this.updatedAt,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    id: json["id"] == null ? null : json["id"],
    transaksiId: json["transaksi_id"] == null ? null : json["transaksi_id"],
    produkId: json["produk_id"] == null ? null : json["produk_id"],
    foto: json["foto"] == null ? null : json["foto"],
    nama: json["nama"] == null ? null : json["nama"],
    deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
    berat: json["berat"] == null ? null : json["berat"],
    panjang: json["panjang"] == null ? null : json["panjang"],
    lebar: json["lebar"] == null ? null : json["lebar"],
    tinggi: json["tinggi"] == null ? null : json["tinggi"],
    brandProduk: json["brand_produk"] == null ? null : json["brand_produk"],
    harga: json["harga"] == null ? null : json["harga"],
    jumlah: json["jumlah"] == null ? null : json["jumlah"],
    catatan: json["catatan"] == null ? null : json["catatan"],
    gratisOngkir: json["gratis_ongkir"] == null ? null : json["gratis_ongkir"],
    hargaZona: json["harga_zona"] == null ? null : json["harga_zona"],
    nego: json["nego"] == null ? null : json["nego"],
    negoJumlah: json["nego_jumlah"] == null ? null : json["nego_jumlah"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "transaksi_id": transaksiId == null ? null : transaksiId,
    "produk_id": produkId == null ? null : produkId,
    "foto": foto == null ? null : foto,
    "nama": nama == null ? null : nama,
    "deskripsi": deskripsi == null ? null : deskripsi,
    "berat": berat == null ? null : berat,
    "panjang": panjang == null ? null : panjang,
    "lebar": lebar == null ? null : lebar,
    "tinggi": tinggi == null ? null : tinggi,
    "brand_produk": brandProduk == null ? null : brandProduk,
    "harga": harga == null ? null : harga,
    "jumlah": jumlah == null ? null : jumlah,
    "catatan": catatan == null ? null : catatan,
    "gratis_ongkir": gratisOngkir == null ? null : gratisOngkir,
    "harga_zona": hargaZona == null ? null : hargaZona,
    "nego": nego == null ? null : nego,
    "nego_jumlah": negoJumlah == null ? null : negoJumlah,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
