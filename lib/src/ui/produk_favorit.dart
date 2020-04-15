import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_bloc.dart';
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_state.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class ProdukFavorit extends StatefulWidget {
  final UserData user;

  const ProdukFavorit({Key key, @required this.user}) : super(key: key);
  @override
  ProdukFavoritState createState() => ProdukFavoritState();
}

class ProdukFavoritState extends State<ProdukFavorit> with ProductFavState {
  @override
  ProdukFavoritState createState() => this;
  final ProdukFavBloc bloc = ProdukFavBloc();
  @override
  void initState() {
    super.initState();
    firstLoad(this.widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Favorit",
              style:
                  MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor)),
        ),
        body: StreamBuilder<Products>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error) {
                return MyTools.errorWidget(context,
                    message:
                        "Oops You can't see this content, this content isn't available now");
              }
              return _body(context, snapshot.data);
            } else if (snapshot.hasError) {
              return MyTools.errorWidget(context,
                  message: "Error, Can't Load this Content");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          stream: bloc.products,
        ));
  }

  _body(BuildContext context, Products produk) {
    if (produk.data.length == 0) {
      return MyTools.errorWidget(context, message: "Belum Ada Produk Favorit");
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(produk.data.length, (index) {
          final content = produk.data[index];
          return _customTile(context, content);
        }),
      ),
    );
  }

  _backup(Datum content) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Container(
                  width: 40,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text("NO"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text("${1 + 1}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(""),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            "Gambar Produk",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(6.0),
                            width: 100,
                            child: Image.network(content.foto.length == 0
                                ? BaseUrl.baseImage
                                : content.foto[0].foto)),
                      ])),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Nama Produk",
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: double.infinity,
                          child: Text(content.nama, textAlign: TextAlign.left)),
                      Text("")
                    ],
                  ),
                ),
                Spacer(flex: 1),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(""),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(""),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                deleteData(content.id, this.widget.user.id);
//                                      _delete(data[i]['id']);
                              },
                            ),
                          )
                        ],
                      ),
                    )),
              ])),
        ],
      ),
    );
  }

  _customTile(context, Datum result) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
        width: double.infinity,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(result.foto[0].foto),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      (result.nama.length < 25)
                          ? result.nama
                          : result.nama.substring(0, 25) + "...",
                      style: MyTools.boldStyle(
                          size: 14, color: MyTools.darkAccentColor),
                    ),
                    Text(
                      "Rp " +
                          MyTools.priceFormat(int.parse(result.hargaSatuan)),
                      style:
                          MyTools.boldStyle(size: 15, color: Colors.redAccent),
                    ),
//                  Row(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Icon(Icons.stars, color: MyTools.primaryColor,),
//                      SizedBox(width: 5,),
//                      Text(result.)
//                    ],
//                  )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    deleteData(result.id, this.widget.user.id);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Center(
                      child: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 90,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.deepOrange)),
                  child: Center(
                      child: Text(
                    "Tambah ke Keranjang",
                    style:
                        MyTools.boldStyle(color: Colors.deepOrange, size: 14),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
