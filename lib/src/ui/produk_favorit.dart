import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_bloc.dart';
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_state.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class ProdukFavorit extends StatefulWidget {
  @override
  ProdukFavoritState createState() => ProdukFavoritState();
}

class ProdukFavoritState extends State<ProdukFavorit> with ProductFavState{
  @override
  ProdukFavoritState createState() => this;
  final ProdukFavBloc bloc = ProdukFavBloc();

  Future<http.Response> _delete(String id) async {
    //a=a+id;
    print(id);
    var url = BaseUrl.base + 'sekolah/produk_favorit/hapus';

    Map data = {'user_id': "" + nama, 'id': id};
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          "Content-Type": BaseUrl.headers.contentTypeJson,
          "API-App": BaseUrl.headers.apiApp,
          "Api-Key": BaseUrl.headers.apiKey,
          "API-Token": BaseUrl.headers.apiToken
        },
        body: body);
    // print("${response.statusCode}");

    //print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    //print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _berhasil(context);
      ProdukFavorit();
    } else {
      // savedata();
      _showAlert(context);
    }
    return response;
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("maaf gagal edit"),
            ));
  }

  void _berhasil(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Buku telah dihapus dari daftar favorit"),
            ));
  }

  String nama;
  List data, data2;
//  Future<String> getJsonData() async {
//    var response = await http.post(
//        //Encode the url
//
//        Uri.encodeFull(
//            BaseUrl.base + 'sekolah/produk_favorit/tampil'),
//        headers: {
//          "Content-Type": BaseUrl.headers.contentTypeurlx,
//          "API-App": BaseUrl.headers.apiApp,
//          "Api-Key": BaseUrl.headers.apiKey,
//          "API-Token": BaseUrl.headers.apiToken
//        },
//        body: {
//          "user_id": "" + nama,
//        });
//    //print(response.body);
//    setState(() {
//      // ignore: deprecated_member_use
//      var convertDataToJson = json.decode(response.body);
//      data = convertDataToJson['Data'];
//      data2 = convertDataToJson['Data'][0]['foto'];
//    });
//  }
//
//  getCredential() async {
//    final pref = await SharedPreferences.getInstance();
//    setState(() {
//      nama = pref.getString("id");
//      getJsonData();
//    });
//    print("id = " + nama);
//  }

  @override
  void initState() {
    super.initState();
    firstLoad();
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
