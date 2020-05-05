// To parse this JSON data, do
//
//     final orderInMitra = orderInMitraFromJson(jsonString);

import 'dart:convert';

OrderInMitra orderInMitraFromJson(String str) => OrderInMitra.fromJson(json.decode(str));

String orderInMitraToJson(OrderInMitra data) => json.encode(data.toJson());

class OrderInMitra {
    bool error;
    dynamic pesanSys;
    dynamic pesanUsr;
    List<Datum> data;
    Paging paging;

    OrderInMitra({
        this.error,
        this.pesanSys,
        this.pesanUsr,
        this.data,
        this.paging,
    });

    factory OrderInMitra.fromJson(Map<String, dynamic> json) => OrderInMitra(
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
    dynamic noResi;
    dynamic orderId;
    dynamic pembayaranType;
    dynamic pembayaranMelalui;
    dynamic pembayaranCreate;
    dynamic pembayaranExpired;
    String marketingId;
    dynamic marketingKode;
    dynamic marketingNama;
    String userId;
    dynamic userFoto;
    String userNama;
    String userEmail;
    String userAlamat;
    String userTelepon;
    dynamic userSekolahLogo;
    String userSekolahNama;
    String userSekolahAlamat;
    String userSekolahNoHp;
    String noInvoice;
    String purchaseOrder;
    DateTime tanggal;
    String dataAlamatPengirimanId;
    String dataAlamatPengirimanNama;
    String dataAlamatPengirimanPenerimaNama;
    String dataAlamatPengirimanPenerimaTelepon;
    String dataAlamatPengirimanKodePos;
    String dataAlamatPengirimanProvinsiId;
    String dataAlamatPengirimanProvinsiNama;
    String dataAlamatPengirimanKabupatenId;
    String dataAlamatPengirimanKabupatenNama;
    String dataAlamatPengirimanKecamatanId;
    String dataAlamatPengirimanKecamatanNama;
    String dataAlamatPengirimanAlamat;
    String dataKurirId;
    String kurir;
    dynamic kurirKode;
    dynamic kurirService;
    dynamic kurirServiceDeskripsi;
    String dataKurirNama;
    String kurirOngkir;
    String status;
    dynamic payment;
    String statusNama;
    dynamic logDitolak;
    dynamic logDiproses;
    dynamic logDikirim;
    dynamic logDiterima;
    dynamic logDibayar;
    dynamic alasanDitolak;
    dynamic bastFile;
    String buktiPembayaranFile;
    dynamic buktiPembayaranType;
    List<Produk> produk;
    dynamic ajukanPencairanTanggal;
    dynamic ajukanPencairanSuccess;
    dynamic ajukanPencairanBukti;
    Files files;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        this.id,
        this.noResi,
        this.orderId,
        this.pembayaranType,
        this.pembayaranMelalui,
        this.pembayaranCreate,
        this.pembayaranExpired,
        this.marketingId,
        this.marketingKode,
        this.marketingNama,
        this.userId,
        this.userFoto,
        this.userNama,
        this.userEmail,
        this.userAlamat,
        this.userTelepon,
        this.userSekolahLogo,
        this.userSekolahNama,
        this.userSekolahAlamat,
        this.userSekolahNoHp,
        this.noInvoice,
        this.purchaseOrder,
        this.tanggal,
        this.dataAlamatPengirimanId,
        this.dataAlamatPengirimanNama,
        this.dataAlamatPengirimanPenerimaNama,
        this.dataAlamatPengirimanPenerimaTelepon,
        this.dataAlamatPengirimanKodePos,
        this.dataAlamatPengirimanProvinsiId,
        this.dataAlamatPengirimanProvinsiNama,
        this.dataAlamatPengirimanKabupatenId,
        this.dataAlamatPengirimanKabupatenNama,
        this.dataAlamatPengirimanKecamatanId,
        this.dataAlamatPengirimanKecamatanNama,
        this.dataAlamatPengirimanAlamat,
        this.dataKurirId,
        this.kurir,
        this.kurirKode,
        this.kurirService,
        this.kurirServiceDeskripsi,
        this.dataKurirNama,
        this.kurirOngkir,
        this.status,
        this.payment,
        this.statusNama,
        this.logDitolak,
        this.logDiproses,
        this.logDikirim,
        this.logDiterima,
        this.logDibayar,
        this.alasanDitolak,
        this.bastFile,
        this.buktiPembayaranFile,
        this.buktiPembayaranType,
        this.produk,
        this.ajukanPencairanTanggal,
        this.ajukanPencairanSuccess,
        this.ajukanPencairanBukti,
        this.files,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        noResi: json["no_resi"],
        orderId: json["order_id"],
        pembayaranType: json["pembayaran_type"],
        pembayaranMelalui: json["pembayaran_melalui"],
        pembayaranCreate: json["pembayaran_create"],
        pembayaranExpired: json["pembayaran_expired"],
        marketingId: json["marketing_id"] == null ? null : json["marketing_id"],
        marketingKode: json["marketing_kode"],
        marketingNama: json["marketing_nama"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userFoto: json["user_foto"],
        userNama: json["user_nama"] == null ? null : json["user_nama"],
        userEmail: json["user_email"] == null ? null : json["user_email"],
        userAlamat: json["user_alamat"] == null ? null : json["user_alamat"],
        userTelepon: json["user_telepon"] == null ? null : json["user_telepon"],
        userSekolahLogo: json["user_sekolah_logo"],
        userSekolahNama: json["user_sekolah_nama"] == null ? null : json["user_sekolah_nama"],
        userSekolahAlamat: json["user_sekolah_alamat"] == null ? null : json["user_sekolah_alamat"],
        userSekolahNoHp: json["user_sekolah_no_hp"] == null ? null : json["user_sekolah_no_hp"],
        noInvoice: json["no_invoice"] == null ? null : json["no_invoice"],
        purchaseOrder: json["purchase_order"] == null ? null : json["purchase_order"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        dataAlamatPengirimanId: json["data_alamat_pengiriman_id"] == null ? null : json["data_alamat_pengiriman_id"],
        dataAlamatPengirimanNama: json["data_alamat_pengiriman_nama"] == null ? null : json["data_alamat_pengiriman_nama"],
        dataAlamatPengirimanPenerimaNama: json["data_alamat_pengiriman_penerima_nama"] == null ? null : json["data_alamat_pengiriman_penerima_nama"],
        dataAlamatPengirimanPenerimaTelepon: json["data_alamat_pengiriman_penerima_telepon"] == null ? null : json["data_alamat_pengiriman_penerima_telepon"],
        dataAlamatPengirimanKodePos: json["data_alamat_pengiriman_kode_pos"] == null ? null : json["data_alamat_pengiriman_kode_pos"],
        dataAlamatPengirimanProvinsiId: json["data_alamat_pengiriman_provinsi_id"] == null ? null : json["data_alamat_pengiriman_provinsi_id"],
        dataAlamatPengirimanProvinsiNama: json["data_alamat_pengiriman_provinsi_nama"] == null ? null : json["data_alamat_pengiriman_provinsi_nama"],
        dataAlamatPengirimanKabupatenId: json["data_alamat_pengiriman_kabupaten_id"] == null ? null : json["data_alamat_pengiriman_kabupaten_id"],
        dataAlamatPengirimanKabupatenNama: json["data_alamat_pengiriman_kabupaten_nama"] == null ? null : json["data_alamat_pengiriman_kabupaten_nama"],
        dataAlamatPengirimanKecamatanId: json["data_alamat_pengiriman_kecamatan_id"] == null ? null : json["data_alamat_pengiriman_kecamatan_id"],
        dataAlamatPengirimanKecamatanNama: json["data_alamat_pengiriman_kecamatan_nama"] == null ? null : json["data_alamat_pengiriman_kecamatan_nama"],
        dataAlamatPengirimanAlamat: json["data_alamat_pengiriman_alamat"] == null ? null : json["data_alamat_pengiriman_alamat"],
        dataKurirId: json["data_kurir_id"] == null ? null : json["data_kurir_id"],
        kurir: json["kurir"] == null ? null : json["kurir"],
        kurirKode: json["kurir_kode"],
        kurirService: json["kurir_service"],
        kurirServiceDeskripsi: json["kurir_service_deskripsi"],
        dataKurirNama: json["data_kurir_nama"] == null ? null : json["data_kurir_nama"],
        kurirOngkir: json["kurir_ongkir"] == null ? null : json["kurir_ongkir"],
        status: json["status"] == null ? null : json["status"],
        payment: json["payment"],
        statusNama: json["status_nama"] == null ? null : json["status_nama"],
        logDitolak: json["log_ditolak"],
        logDiproses: json["log_diproses"],
        logDikirim: json["log_dikirim"],
        logDiterima: json["log_diterima"],
        logDibayar: json["log_dibayar"],
        alasanDitolak: json["alasan_ditolak"],
        bastFile: json["bast_file"],
        buktiPembayaranFile: json["bukti_pembayaran_file"] == null ? null : json["bukti_pembayaran_file"],
        buktiPembayaranType: json["bukti_pembayaran_type"],
        produk: json["produk"] == null ? null : List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
        ajukanPencairanTanggal: json["ajukan_pencairan_tanggal"],
        ajukanPencairanSuccess: json["ajukan_pencairan_success"],
        ajukanPencairanBukti: json["ajukan_pencairan_bukti"],
        files: json["files"] == null ? null : Files.fromJson(json["files"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "no_resi": noResi,
        "order_id": orderId,
        "pembayaran_type": pembayaranType,
        "pembayaran_melalui": pembayaranMelalui,
        "pembayaran_create": pembayaranCreate,
        "pembayaran_expired": pembayaranExpired,
        "marketing_id": marketingId == null ? null : marketingId,
        "marketing_kode": marketingKode,
        "marketing_nama": marketingNama,
        "user_id": userId == null ? null : userId,
        "user_foto": userFoto,
        "user_nama": userNama == null ? null : userNama,
        "user_email": userEmail == null ? null : userEmail,
        "user_alamat": userAlamat == null ? null : userAlamat,
        "user_telepon": userTelepon == null ? null : userTelepon,
        "user_sekolah_logo": userSekolahLogo,
        "user_sekolah_nama": userSekolahNama == null ? null : userSekolahNama,
        "user_sekolah_alamat": userSekolahAlamat == null ? null : userSekolahAlamat,
        "user_sekolah_no_hp": userSekolahNoHp == null ? null : userSekolahNoHp,
        "no_invoice": noInvoice == null ? null : noInvoice,
        "purchase_order": purchaseOrder == null ? null : purchaseOrder,
        "tanggal": tanggal == null ? null : tanggal.toIso8601String(),
        "data_alamat_pengiriman_id": dataAlamatPengirimanId == null ? null : dataAlamatPengirimanId,
        "data_alamat_pengiriman_nama": dataAlamatPengirimanNama == null ? null : dataAlamatPengirimanNama,
        "data_alamat_pengiriman_penerima_nama": dataAlamatPengirimanPenerimaNama == null ? null : dataAlamatPengirimanPenerimaNama,
        "data_alamat_pengiriman_penerima_telepon": dataAlamatPengirimanPenerimaTelepon == null ? null : dataAlamatPengirimanPenerimaTelepon,
        "data_alamat_pengiriman_kode_pos": dataAlamatPengirimanKodePos == null ? null : dataAlamatPengirimanKodePos,
        "data_alamat_pengiriman_provinsi_id": dataAlamatPengirimanProvinsiId == null ? null : dataAlamatPengirimanProvinsiId,
        "data_alamat_pengiriman_provinsi_nama": dataAlamatPengirimanProvinsiNama == null ? null : dataAlamatPengirimanProvinsiNama,
        "data_alamat_pengiriman_kabupaten_id": dataAlamatPengirimanKabupatenId == null ? null : dataAlamatPengirimanKabupatenId,
        "data_alamat_pengiriman_kabupaten_nama": dataAlamatPengirimanKabupatenNama == null ? null : dataAlamatPengirimanKabupatenNama,
        "data_alamat_pengiriman_kecamatan_id": dataAlamatPengirimanKecamatanId == null ? null : dataAlamatPengirimanKecamatanId,
        "data_alamat_pengiriman_kecamatan_nama": dataAlamatPengirimanKecamatanNama == null ? null : dataAlamatPengirimanKecamatanNama,
        "data_alamat_pengiriman_alamat": dataAlamatPengirimanAlamat == null ? null : dataAlamatPengirimanAlamat,
        "data_kurir_id": dataKurirId == null ? null : dataKurirId,
        "kurir": kurir == null ? null : kurir,
        "kurir_kode": kurirKode,
        "kurir_service": kurirService,
        "kurir_service_deskripsi": kurirServiceDeskripsi,
        "data_kurir_nama": dataKurirNama == null ? null : dataKurirNama,
        "kurir_ongkir": kurirOngkir == null ? null : kurirOngkir,
        "status": status == null ? null : status,
        "payment": payment,
        "status_nama": statusNama == null ? null : statusNama,
        "log_ditolak": logDitolak,
        "log_diproses": logDiproses,
        "log_dikirim": logDikirim,
        "log_diterima": logDiterima,
        "log_dibayar": logDibayar,
        "alasan_ditolak": alasanDitolak,
        "bast_file": bastFile,
        "bukti_pembayaran_file": buktiPembayaranFile == null ? null : buktiPembayaranFile,
        "bukti_pembayaran_type": buktiPembayaranType,
        "produk": produk == null ? null : List<dynamic>.from(produk.map((x) => x.toJson())),
        "ajukan_pencairan_tanggal": ajukanPencairanTanggal,
        "ajukan_pencairan_success": ajukanPencairanSuccess,
        "ajukan_pencairan_bukti": ajukanPencairanBukti,
        "files": files == null ? null : files.toJson(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
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
    dynamic transaksiId;
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
    dynamic catatan;
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
        transaksiId: json["transaksi_id"],
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
        catatan: json["catatan"],
        gratisOngkir: json["gratis_ongkir"] == null ? null : json["gratis_ongkir"],
        hargaZona: json["harga_zona"] == null ? null : json["harga_zona"],
        nego: json["nego"] == null ? null : json["nego"],
        negoJumlah: json["nego_jumlah"] == null ? null : json["nego_jumlah"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "transaksi_id": transaksiId,
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
        "catatan": catatan,
        "gratis_ongkir": gratisOngkir == null ? null : gratisOngkir,
        "harga_zona": hargaZona == null ? null : hargaZona,
        "nego": nego == null ? null : nego,
        "nego_jumlah": negoJumlah == null ? null : negoJumlah,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}

class Paging {
    bool pagination;
    String halaman;
    int dataKe;
    String jmlData;
    String jmlHalaman;
    String infoPaging;

    Paging({
        this.pagination,
        this.halaman,
        this.dataKe,
        this.jmlData,
        this.jmlHalaman,
        this.infoPaging,
    });

    factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        pagination: json["Pagination"] == null ? null : json["Pagination"],
        halaman: json["Halaman"] == null ? null : json["Halaman"],
        dataKe: json["Data_ke"] == null ? null : json["Data_ke"],
        jmlData: json["Jml_data"] == null ? null : json["Jml_data"],
        jmlHalaman: json["Jml_halaman"] == null ? null : json["Jml_halaman"],
        infoPaging: json["Info_paging"] == null ? null : json["Info_paging"],
    );

    Map<String, dynamic> toJson() => {
        "Pagination": pagination == null ? null : pagination,
        "Halaman": halaman == null ? null : halaman,
        "Data_ke": dataKe == null ? null : dataKe,
        "Jml_data": jmlData == null ? null : jmlData,
        "Jml_halaman": jmlHalaman == null ? null : jmlHalaman,
        "Info_paging": infoPaging == null ? null : infoPaging,
    };
}
