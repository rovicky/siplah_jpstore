// To parse this JSON data, do
//
//     final productsMitra = productsMitraFromJson(jsonString);

import 'dart:convert';

import 'package:siplah_jpmall/src/models/mitra/product_mitra_model.dart';

ProductsMitra productsMitraFromJson(String str) => ProductsMitra.fromJson(json.decode(str));

String productsMitraToJson(ProductsMitra data) => json.encode(data.toJson());

class ProductsMitra {
    bool error;
    dynamic errorSys;
    dynamic errorUsr;
    List<ProductMitraModel> data;
    dynamic draw;
    int recordsTotal;
    int recordsFiltered;

    ProductsMitra({
        this.error,
        this.errorSys,
        this.errorUsr,
        this.data,
        this.draw,
        this.recordsTotal,
        this.recordsFiltered,
    });

    factory ProductsMitra.fromJson(Map<String, dynamic> json) => ProductsMitra(
        error: json["Error"] == null ? null : json["Error"],
        errorSys: json["Error_sys"],
        errorUsr: json["Error_usr"],
        data: json["Data"] == null ? null : List<ProductMitraModel>.from(json["Data"].map((x) => ProductMitraModel.fromJson(x))),
        draw: json["draw"],
        recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
    );

    Map<String, dynamic> toJson() => {
        "Error": error == null ? null : error,
        "Error_sys": errorSys,
        "Error_usr": errorUsr,
        "Data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "draw": draw,
        "recordsTotal": recordsTotal == null ? null : recordsTotal,
        "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
    };
}

class Products {
    String id;
    String nama;
    String deskripsi;
    String sku;
    String kondisi;
    String stok;
    String stokSlaluAda;
    String berat;
    String panjang;
    String lebar;
    String tinggi;
    String pembelianMinimum;
    String kelipatanPembelian;
    String hargaSatuan;
    String skKementrian;
    String brandProduk;
    String kategoriId;
    String kategoriNama;//1
    String terbit;
    List<Foto> foto;
    dynamic kelas;
    dynamic jenjang;
    dynamic hargaZona;
    DateTime createdAt;
    DateTime updatedAt;

    Products({
        this.id,
        this.nama,
        this.deskripsi,
        this.sku,
        this.kondisi,
        this.stok,
        this.stokSlaluAda,
        this.berat,
        this.panjang,
        this.lebar,
        this.tinggi,
        this.pembelianMinimum,
        this.kelipatanPembelian,
        this.hargaSatuan,
        this.skKementrian,
        this.brandProduk,
        this.kategoriId,
        this.kategoriNama,
        this.terbit,
        this.foto,
        this.kelas,
        this.jenjang,
        this.hargaZona,
        this.createdAt,
        this.updatedAt,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"] == null ? null : json["id"],
        nama: json["nama"] == null ? null : json["nama"],
        deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
        sku: json["sku"] == null ? null : json["sku"],
        kondisi: json["kondisi"] == null ? null : json["kondisi"],
        stok: json["stok"] == null ? null : json["stok"],
        stokSlaluAda: json["stok_slalu_ada"] == null ? null : json["stok_slalu_ada"],
        berat: json["berat"] == null ? null : json["berat"],
        panjang: json["panjang"] == null ? null : json["panjang"],
        lebar: json["lebar"] == null ? null : json["lebar"],
        tinggi: json["tinggi"] == null ? null : json["tinggi"],
        pembelianMinimum: json["pembelian_minimum"] == null ? null : json["pembelian_minimum"],
        kelipatanPembelian: json["kelipatan_pembelian"] == null ? null : json["kelipatan_pembelian"],
        hargaSatuan: json["harga_satuan"] == null ? null : json["harga_satuan"],
        skKementrian: json["sk_kementrian"] == null ? null : json["sk_kementrian"],
        brandProduk: json["brand_produk"] == null ? null : json["brand_produk"],
        kategoriId: json["kategori_id"] == null ? null : json["kategori_id"],
        kategoriNama: json["kategori_nama"] == null ? null : json["kategori_nama"],
        terbit: json["terbit"] == null ? null : json["terbit"],
        foto: json["foto"] == null ? null : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
        kelas: json["kelas"],
        jenjang: json["jenjang"],
        hargaZona: json["harga_zona"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama": nama == null ? null : nama,
        "deskripsi": deskripsi == null ? null : deskripsi,
        "sku": sku == null ? null : sku,
        "kondisi": kondisi == null ? null : kondisi,
        "stok": stok == null ? null : stok,
        "stok_slalu_ada": stokSlaluAda == null ? null : stokSlaluAda,
        "berat": berat == null ? null : berat,
        "panjang": panjang == null ? null : panjang,
        "lebar": lebar == null ? null : lebar,
        "tinggi": tinggi == null ? null : tinggi,
        "pembelian_minimum": pembelianMinimum == null ? null : pembelianMinimum,
        "kelipatan_pembelian": kelipatanPembelian == null ? null : kelipatanPembelian,
        "harga_satuan": hargaSatuan == null ? null : hargaSatuan,
        "sk_kementrian": skKementrian == null ? null : skKementrian,
        "brand_produk": brandProduk == null ? null : brandProduk,
        "kategori_id": kategoriId == null ? null : kategoriId,
        "kategori_nama": kategoriNama == null ? null : kategoriNama,
        "terbit": terbit == null ? null : terbit,
        "foto": foto == null ? null : List<dynamic>.from(foto.map((x) => x.toJson())),
        "kelas": kelas,
        "jenjang": jenjang,
        "harga_zona": hargaZona,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}

class Foto {
    String id;
    String foto;
    DateTime createdAt;
    DateTime updatedAt;

    Foto({
        this.id,
        this.foto,
        this.createdAt,
        this.updatedAt,
    });

    factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        id: json["id"] == null ? null : json["id"],
        foto: json["foto"] == null ? null : json["foto"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "foto": foto == null ? null : foto,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
