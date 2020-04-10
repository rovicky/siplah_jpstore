import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/ui/star.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sidekick/flutter_sidekick.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';

class GridProduk extends StatefulWidget {
  final UserData user;
  final Datum result;

  const GridProduk({Key key, this.result, @required this.user})
      : super(key: key);

  @override
  _GridProdukState createState() => _GridProdukState();
}

class _GridProdukState extends State<GridProduk> {
  var f = NumberFormat("#,##0", "en_US");
  var liked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<http.Response> _setfavorit(String id) async {
    var url = 'http://siplah.mascitra.co.id/api/sekolah/produk_favorit/tambah';

    Map data = {
      'user_id': "" + this.widget.user.id,
      'produk_id': id,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "API-App": "siplah_jpmall.id",
          "Api-Key": "4P1_7Pm411_51p114h",
          "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
        },
        body: body);
    // print("${response.statusCode}");

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    //print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      _berhasil(context);
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
              content: Text("Buku Telah Masuk Dalam Menu Favorit"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double ratio =
        MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
    return widget.result == null
        ? Container()
        : GridView.builder(
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, i) {
              var star = 5;
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 350),
                        pageBuilder: (context, _, __) => ProductDetailPage(
                              productId: widget.result.produk[i].id,
                              user: this.widget.user,
                            ))),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Hero(
                              tag: 'image-${widget.result.produk[i].produk}',
                              child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(widget
                                                      .result.produk[i].foto !=
                                                  null
                                              ? widget
                                                  .result.produk[i].foto[0].foto
                                              : 'http://siplah.mascitra.co.id/assets/images/no-image.png')),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)))),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      setState(() {});
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      _setfavorit(widget.result.produk[i].id);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.favorite_border,
                                        color:
                                            liked == true ? Colors.red : null,
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          width: 150,
                          height: 50,
                          // color: Colors.black,
                          child: Text(
                            widget.result.produk[i].produk,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 150,
                          // color: Colors.black,
                          child: Text(
                            "Rp " + widget.result.produk[i].harga,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          width: 150,
                          height: 20,
                          child: Row(
                            children: <Widget>[
                              Text(widget.result.produk[i].kabupatenNama)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Container(
                            width: 150,
                            child: StarDisplay(
                              value: 4,
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: widget.result.produk.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
//      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: MediaQuery.of(context).size.height /2.5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: ratio <= 2 ? 0.55 : 0.65),
          );
  }
}

//gridView(AsyncSnapshot<List<Products>> snapshot){

//}
