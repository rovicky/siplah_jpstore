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
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class GridProduk extends StatefulWidget {
  final UserData user;
  final Datum result;

  const GridProduk({Key key, this.result, @required this.user})
      : super(key: key);

  @override
  _GridProdukState createState() => _GridProdukState();
}

class _GridProdukState extends State<GridProduk> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return widget.result == null
        ? Container()
        : GridView.count(
      crossAxisCount: 2,
      childAspectRatio: height/width < 2 ? 0.8 : 0.85,
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.vertical,
      children: List.generate(this.widget.result.produk.length, (index) => _listProducts(context, this.widget.result.produk[index])),
            );
  }
  _listProducts(context, Produk result ) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                mitraId: result.userId,
                user: this.widget.user,
                categoryId: this.widget.result.id,
                productId:
                result.id,
              ))),
      child: Container(
        padding: const EdgeInsets.only(
            top: 8.0, left: 10, right: 10),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 5,),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            result
                                .foto == null ? BaseUrl.baseImage : result
                                .foto[0]
                                .foto))),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 40,
                  child: Text(
                    result.produk,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MyTools.boldStyle(
                        size: 13,
                        color:
                        MyTools.darkAccentColor),
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                child: Text(result.harga == "0" ? "harga zona" :
                "Rp " + result.harga,
                  textAlign: TextAlign.left,
                  style: MyTools.boldStyle(
                      size: 14,
                      color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 3,),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
//                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.store, size: 15, color: MyTools.primaryColor,),
                    SizedBox(width: 3,),
                    Text(result.userNama.length < 15 ? result.userNama : result.userNama.substring(0, 15) + "...",
                      style: MyTools.regular(
                          size: 10,
                          color: MyTools.darkAccentColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, top: 3, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
//                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.location_on, size: 15, color: Colors.redAccent,),
                    SizedBox(width: 3,),
                    Text(result.kabupatenNama,
                      style: MyTools.regular(
                          size: 10,
                          color: MyTools.darkAccentColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
