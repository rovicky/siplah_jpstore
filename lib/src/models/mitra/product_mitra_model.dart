class ProductMitraModel {
  final String id;
  final String userId;
  final String nama;
  final String kategoriId;
  final String deskripsi;
  final String sku;
  final String kondisi;
  final String stok;
  final String berat;
  final String panjang;
  final String lebar;
  final String tinggi;
  final String pembelianMinimum;
  final String kelipatanPembelian;
  final String stokSlaluAda;
  final String hargaSatuan;
  final List<HargaZona> hargaZona;
  final List<String> jenjang;
  final List<String> kelas;
  final List<Foto> foto;
  final String terbit;
  final String skKementrian;
  final String brandProduk;
  final String kategoriNama;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductMitraModel({
    this.id,
    this.userId,
    this.kategoriId,
    this.nama,
    this.deskripsi,
    this.sku,
    this.kondisi,
    this.stok,
    this.berat,
    this.panjang,
    this.lebar,
    this.tinggi,
    this.pembelianMinimum,
    this.kelipatanPembelian,
    this.jenjang,
    this.kelas,
    this.hargaSatuan,
    this.hargaZona,
    this.terbit,
    this.foto,
    this.skKementrian,
    this.stokSlaluAda,
    this.brandProduk,
    this.kategoriNama,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductMitraModel.fromJson(Map<String, dynamic> json) =>
      ProductMitraModel(
          id: json["id"] == null ? null :json['id'].toString(),
          userId: json["user_id"] == null ? null :json['user_id'].toString(),
          kategoriId: json["kategori_id"] == null ? null :json['kategori_id'],
          nama: json["nama"] == null ? null :json['nama'].toString(),
          deskripsi: json["deskripsi"] == null ? null :json['deskripsi'].toString(),
          sku: json["sku"] == null ? null :json['sku'].toString(),
          kondisi: json["kondisi"] == null ? null :json['kondisi'].toString(),
          stok: json["stok"] == null ? null :json['stok'].toString(),
          berat: json["berat"] == null ? null :json['berat'].toString(),
          lebar: json["lebar"] == null ? null :json['lebar'],
          panjang: json["panjang"] == null ? null :json['panjang'].toString(),
          tinggi: json["tinggi"] == null ? null :json['tinggi'].toString(),
          pembelianMinimum: json["pembelian_minimum"] == null ? null :json['pembelian_minimum'].toString(),
          kelipatanPembelian: json["kelipatan_pembelian"] == null ? null :json['kelipatan_pembelian'].toString(),
          hargaSatuan: json["harga_satuan"] == null ? null :json['harga_satuan'].toString(),
          hargaZona: json["harga_zona"] == null ? null : List<HargaZona>.from(
              json['harga_zona'].map((x) => HargaZona.fromJson(x))),
          terbit: json["terbit"] == null ? null :json['terbit'].toString(),
          skKementrian: json["Data"] == null ? null :json["Data"] == null ? null :json['sk_kementrian'].toString(),
          stokSlaluAda: json["stok_slalu_ada"] == null ? null :json['stok_slalu_ada'],
          jenjang: json["jenjang"] == null ? null :json['jenjang'],
          foto: json["foto"] == null ? null :List<Foto>.from(json['foto'].map((x) => Foto.fromJson(x))),
          kelas: json["kelas"] == null ? null :json['kelas'],
          brandProduk: json["brand_produk"] == null ? null :json['brand_produk'].toString());

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "kategori_id": kategoriId,
        "nama": nama,
        "deskripsi": deskripsi,
        "sku": sku,
        "kondisi": kondisi,
        "stok": stok,
        "berat": berat,
        "lebar": lebar,
        "foto": List.generate(foto.length,
            (index) => {"id": foto[index].id, "foto": foto[index].foto}),
        "panjang": panjang,
        "tinggi": tinggi,
        "pembelian_minimum": pembelianMinimum,
        "kelipatan_pembelian": kelipatanPembelian,
        "harga_satuan": hargaSatuan,
        "harga_zona": List.generate(
            hargaZona.length,
            (index) =>
                {"id": hargaZona[index].id, "harga": hargaZona[index].harga}),
        "terbit": terbit,
        "sk_kementrian": skKementrian,
        "brand_produk": brandProduk,
        "jenjang": jenjang,
        "kelas": kelas,
      };
}

class Foto {
  final String id;
  final String foto;

  Foto({this.id, this.foto});

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        foto: json['foto'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {"id": id, "foto": foto};
}

class HargaZona {
  final String id;
  final String harga;

  HargaZona({this.id, this.harga});

  factory HargaZona.fromJson(Map<String, dynamic> json) => HargaZona(
        harga: json['harga'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {"id": id, "harga": harga};
}
