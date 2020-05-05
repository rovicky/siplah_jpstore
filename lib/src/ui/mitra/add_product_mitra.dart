import 'package:notus/convert.dart';

import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/add_product_mitra_state.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/models/mitra/product_mitra_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/add_product/form_harga.dart';
import 'package:siplah_jpmall/src/ui/add_product/form_lainnya.dart';
import 'package:siplah_jpmall/src/ui/add_product/form_pembelian.dart';
import 'package:siplah_jpmall/src/ui/add_product/form_pickFoto.dart';
import 'package:siplah_jpmall/src/ui/add_product/form_ship.dart';
import 'package:siplah_jpmall/src/ui/add_product/form_stock.dart';
import 'package:siplah_jpmall/src/ui/mitra/pick_category.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';
import 'package:zefyr/zefyr.dart';

class AddProductMitra extends StatefulWidget {
  final UserData user;
  final VoidCallback callback;
  final ProductMitraModel model;

  const AddProductMitra({Key key, this.user, this.callback, this.model})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => AddProductMitraPageState();
}

class AddProductMitraPageState extends State<AddProductMitra>
    with AddProductMitraState {
  var kategori, stok, pengiriman, pembelian, harga, lainnya;
  Map<String, dynamic> foto;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final bloc = MitraBloc();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      setState(() {
        var description = widget.model.deskripsi;

        nameProduct = TextEditingController(text: widget.model.nama);
        skKementrian = TextEditingController(text: widget.model.skKementrian);
        brand = TextEditingController(text: widget.model.brandProduk);
        getDocument(description).then((value) {
          setState(() => descriptionProduct = ZefyrController(value));
        });
        // descriptionProduct = ZefyrController(NotusDocument.fromDelta(
        //     notusMarkdown.decode(html2md.convert(description))));
        // print(notusMarkdown.decode(html2md.convert(widget.model.deskripsi)));
            
        stok = {
          "sku": widget.model.sku,
          "stok": widget.model.stok,
          "stok_slalu_ada": widget.model.stokSlaluAda,
          "kondisi": widget.model.kondisi,
        };
        pengiriman = {
          "berat": widget.model.berat,
          "panjang": widget.model.panjang,
          "tinggi": widget.model.tinggi,
          "lebar": widget.model.lebar,
        };
        pembelian = {
          "pembelian_minimum": widget.model.pembelianMinimum,
          "kelipatan_pembelian": widget.model.kelipatanPembelian
        };
        lainnya = {
          "jenjang":widget.model.jenjang,
          "kelas":widget.model.kelas,
          "terbit":widget.model.terbit,
        };
        harga = {
          "harga_satuan":widget.model.hargaSatuan,
          "harga_zona":widget.model.hargaZona,
        };
        foto = {
          "foto": List.generate(widget.model.foto.length, (index) => {
            "id":widget.model.foto[index].id,
            "foto":widget.model.foto[index].foto,
          })
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Tambah Produk",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: ZefyrScaffold(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _widgetTextFieldTile(context,
                    controller: nameProduct, hint: "Masukkan Nama Produk"),
                Text(
                  "Deskripsi Produk",
                  style:
                      MyTools.regular(size: 12, color: MyTools.darkAccentColor),
                ),
                _widgetZefyrField(
                  context,
                  controller: descriptionProduct,
                ),
                _widgetListTile(context,
                    key: kategori == null
                        ? "Pilih Kategori"
                        : kategori['title'], onPressed: () async {
                  final navItem = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PickCategory()));
                  if (navItem != null) {
                    setState(() {
                      kategori = navItem;
                    });
                  }
                }),
                _widgetListTile(context,
                    key: stok != null
                        ? stok['sku'] != null || stok['kondisi'] != null
                            ? "Stok (sudah diisi)"
                            : "Stok"
                        : "Stok", onPressed: () async {
                  final navItem = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormStock(
                                value: stok,
                              )));
                  if (navItem != null) {
                    setState(() {
                      stok = navItem;
                    });
                  }
                }),
                _widgetListTile(context,
                    key: pengiriman != null
                        ? "Pengiriman (sudah diisi)"
                        : "Pengiriman", onPressed: () async {
                  final navItem = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormShip(
                                value: pengiriman,
                              )));
                  if (navItem != null) {
                    setState(() {
                      pengiriman = navItem;
                    });
                  }
                }),
                _widgetListTile(context,
                    key: pembelian != null
                        ? "Pembelian (sudah diisi)"
                        : "Pembelian", onPressed: () async {
                  final navItem = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Pembelian(
                                value: pembelian,
                              )));
                  if (navItem != null) {
                    setState(() {
                      pembelian = navItem;
                    });
                  }
                }),
                _widgetListTile(context,
                    key: harga != null ? "Harga (sudah diisi)" : "Harga",
                    onPressed: () async {
                  if (kategori == null) {
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      content: Text(
                        "kategori belum dipilih",
                        style: MyTools.regular(size: 12, color: Colors.white),
                      ),
                    ));
                    print("");
                  } else {
                    final navItem = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormHarga(
                                  value: harga,
                                  categoryId: kategori['id'],
                                )));
                    if (navItem != null) {
                      setState(() {
                        harga = navItem;
                      });
                    }
                  }
                }),
                _widgetListTile(context,
                    key: foto != null ? "Foto (sudah diisi)" : "Foto",
                    onPressed: () async {
                  final navItem = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PickFoto(
                                fotos: foto,
                              )));
                  if (navItem != null) {
                    setState(() {
                      foto = navItem;
                    });
                  }
                }),
                _widgetListTile(context,
                    key: lainnya != null ? "Lainnya (sudah diisi)" : "Lainnya",
                    onPressed: () async {
                  final navItem = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormLainnya(
                                value: lainnya,
                              )));
                  if (navItem != null) {
                    setState(() {
                      lainnya = navItem;
                    });
                  }
                }),
                _widgetTextFieldTile(context,
                    controller: skKementrian, hint: "SK KEMENTRIAN"),
                _widgetTextFieldTile(context, controller: brand, hint: "Brand"),
                _widgetListTile(context, key: "Tambahkan Produk",
                    onPressed: () async {
                  final dess = descriptionProduct.document.toDelta();

                  if (pengiriman != null &&
                      harga != null &&
                      pembelian != null &&
                      nameProduct.text.isNotEmpty &&
                      kategori != null &&
                      stok != null) {
                    var product = ProductMitraModel(
                      berat: pengiriman['berat'],
                      panjang: pengiriman['panjang'],
                      tinggi: pengiriman['tinggi'],
                      lebar: pengiriman['lebar'],
                      deskripsi:
                          await change(NotusMarkdownCodec().encode(dess)),
                      brandProduk: brand.text,
                      hargaSatuan: harga['harga_satuan'],
                      hargaZona: List<HargaZona>.from(
                        harga['harga_zona'].map((x) => HargaZona(
                            harga: x['harga'], id: x['id'].toString())),
                      ),
                      kelipatanPembelian: pembelian['kelipatan_pembelian'],
                      kondisi: stok['kondisi'],
                      nama: nameProduct.text,
                      pembelianMinimum: pembelian['pembelian_minimum'],
                      skKementrian: skKementrian.text,
                      sku: stok['sku'],
                      kategoriId: kategori['id'],
                      stok: stok['stok'],
                      jenjang: lainnya['jenjang'],
                      kelas: lainnya['kelas'],
                      stokSlaluAda: stok['stok_slalu_ada'],
                      terbit: lainnya['terbit'].toString(),
                      foto: List<Foto>.from(
                          foto['foto'].map((x) => Foto(foto: x['foto']))),
                      userId: this.widget.user.id,
                    );
                    createProduct(product).then((value) {
                      if (!value['Error']) {
                        Navigator.pop(context);
                        widget.callback();
                      } else {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(value['Pesan_usr']),
                        ));
                      }
                    });
                  } else {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Form Masih Kosong!"),
                    ));
                  }
                  // print(product.toJson()['harga_zona']);
                  // Navigator.pop(context);

                  // print(jsonEncode(product.toJson()));
                }, color: MyTools.greenLand),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _widgetListTile(context, {String key, Function onPressed, Color color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: onPressed ?? () {},
            title: Text(key ?? "Tidak Ada Judul",
                style: MyTools.boldStyle(
                    size: 13,
                    color: color != null
                        ? Colors.white
                        : MyTools.darkAccentColor)),
          ),
        ),
      ),
    );
  }

  _widgetTextFieldTile(context,
      {String key,
      TextEditingController controller,
      String hint,
      bool isExpand = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
              title: TextField(
            controller: controller,
            expands: isExpand,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: MyTools.regular(
                    size: 12, color: MyTools.darkAccentColor.withOpacity(0.7))),
            style: MyTools.regular(size: 12, color: MyTools.darkAccentColor),
          )),
        ),
      ),
    );
  }

  _widgetZefyrField(context,
      {String key,
      ZefyrController controller,
      String hint,
      bool isExpand = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
              title: ZefyrField(
            focusNode: focusNode,
            controller: controller,
            height: 200,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                alignLabelWithHint: true,
                hintMaxLines: 1,
                hintStyle: MyTools.regular(
                    size: 12, color: MyTools.darkAccentColor.withOpacity(0.7))),
          )),
        ),
      ),
    );
  }

  @override
  AddProductMitraPageState createState() => this;
}
