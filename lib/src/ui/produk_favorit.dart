import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_bloc.dart';
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_state.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class ProdukFavorit extends StatefulWidget {
  final UserData user;

  const ProdukFavorit({Key key, @required this.user}) : super(key: key);
  @override
  ProdukFavoritState createState() => ProdukFavoritState();
}

class ProdukFavoritState extends State<ProdukFavorit> with ProductFavState{
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Produk Favorit", style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<Products>(builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data.error) {
            return Center(child: Text("Oops You can't see this content, this content isn't available now"),);
          }
          return _body(context, snapshot.data);
        }else if(snapshot.hasError) {
          return Center(child: Text("Error, Can't Load this Content"),);
        }return Center(child: CircularProgressIndicator(),);
      }, stream: bloc.products,)
    );
  }

  _body(BuildContext context, Products produk) {
    if(produk.data.length == 0) {
      return Center(child: Text("Tidak Ada Produk Favorit"),);
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(produk.data.length, (index) {
          final content = produk.data[index];
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
                              child: Text("${index + 1}"),
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
                                  child: Image.network(content.foto.length ==
                                      0
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
                            Text("Nama Produk", textAlign: TextAlign.left,),
                            SizedBox(height: 10,),
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
        }),
      ),
    );
  }

  _bodyBackup(BuildContext context, Products produk) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(produk.data.length, (index) {
          final content = produk.data[index];
          return Container(
            child: Column(
              children: <Widget>[
                Card(
                    child: Row(children: <Widget>[
                      Container(
                        width: 100,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text("NO"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text("${index + 1}"),
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
                                  child: Image.network(content.foto.length ==
                                      0
                                      ? BaseUrl.baseImage
                                      : content.foto[0].foto)),
                            ])),
                      ),
                      Container(
                        width: 100,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text("Nama Produk"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                  padding: const EdgeInsets.all(6.0),
                                  width: 120,///
                                  child: Text(content.nama)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(""),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(""),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Text(""),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(""),
                              ),
                            )
                          ],
                        ),
                      ),
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
        }),
      ),
    );
  }
}
