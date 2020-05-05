import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_produk_state.dart';
import 'package:siplah_jpmall/src/models/mitra/product_mitra_model.dart';
import 'package:siplah_jpmall/src/models/mitra/products_mitra_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/mitra/add_product_mitra.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class MitraProductPage extends StatefulWidget {
  final UserData user;

  const MitraProductPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MitraProductPageState();
}

class MitraProductPageState extends State<MitraProductPage>
    with MitraProdukState {
  final bloc = MitraBloc();
  ScrollController controller = ScrollController();
  int start = 0;

  @override
  void initState() {
    super.initState();
    bloc
        .getProductsOfMitra(this.widget.user.id, length: 10, start: start)
        .then((value) {
      list.addAll(value.data);
      setState(() {
        start += 10;
      });
    });
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        bloc
            .getProductsOfMitra(this.widget.user.id, length: 10, start: start)
            .then((value) {
          list.addAll(value.data);
          setState(() {
            start += 10;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Produk Anda",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
              child:
                  _widgetListTile(context, key: "Tambah Produk", onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductMitra(
                              user: this.widget.user,
                              callback: () {
                                list.clear();
                                bloc
                                    .getProductsOfMitra(this.widget.user.id,
                                        length: 10, start: start)
                                    .then((value) {
                                  list.addAll(value.data);
                                  setState(() {
                                    start += 10;
                                  });
                                });
                              },
                            )));
              }),
            ),
            GridView.count(
              childAspectRatio: height / width < 2 ? 0.79 : 0.85,
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  list.length, (index) => _listProducts(context, list[index])),
            ),
            Container(
              height: 30,
              width: 30,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _listProducts(context, ProductMitraModel result) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(result.foto == null
                            ? BaseUrl.baseImage
                            : result.foto[0].foto))),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 35,
                  child: Text(
                    result.nama,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MyTools.boldStyle(
                        size: 12, color: MyTools.darkAccentColor),
                  )),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                child: Text(
                  result.hargaSatuan == "0"
                      ? "harga zona"
                      : "Rp " + result.hargaSatuan,
                  textAlign: TextAlign.left,
                  style: MyTools.boldStyle(size: 13, color: Colors.redAccent),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProductMitra(
                                  user: this.widget.user,
                                  model: result,
                                ))),
                    child: Container(
                      width: 50,
                      height: 30,
                      child: Center(
                          child: Icon(
                        Icons.edit,
                        size: 15,
                        color: Colors.white,
                      )),
                      decoration: BoxDecoration(
                          color: MyTools.greenLand,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 50,
                    height: 30,
                    child: Center(
                        child: Icon(
                      Icons.delete_outline,
                      size: 15,
                      color: MyTools.redColor,
                    )),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyTools.redColor, width: 3),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _widgetListTile(context, {String key, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
        height: 70,
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
            onTap: onPressed ?? () {},
            title: Text(key ?? "Tidak Ada Judul",
                style: MyTools.boldStyle(
                    size: 14, color: MyTools.darkAccentColor)),
          ),
        ),
      ),
    );
  }

  @override
  MitraProductPageState createState() => this;
}
