import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:siplah_jpmall/src/bloc/product_details/product_detail_bloc.dart';
import 'package:siplah_jpmall/src/bloc/product_details/product_detail_state.dart';
import 'package:siplah_jpmall/src/models/product_detail.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/mitra/detail_mitra.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class ProductDetailPage extends StatefulWidget {
  final UserData user;
  final String productId;
  final String mitraId;
  final String categoryId;

  const ProductDetailPage(
      {Key key,
      this.user,
      this.productId,
      @required this.mitraId,
      this.categoryId})
      : super(key: key);
  @override
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage>
    with ProductDetailState {
  final ProductDetailBloc bloc = ProductDetailBloc();
  final _skey = GlobalKey<ScaffoldState>();
  int initialPage = 0;
  PageController controller;
  @override
  ProductDetailPageState createState() => this;

  @override
  void initState() {
    super.initState();
    firstLoad(this.widget.productId, (this.widget.user == null) ? '' : this.widget.user.id);
    controller = PageController(
        initialPage: initialPage, keepPage: true, viewportFraction: 1.0);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _skey,
        body: StreamBuilder<ProductDetail>(
            stream: bloc?.product,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.id == "00") {
                  return MyTools.errorWidget(context,
                      message: "Can't Load Anything!");
                } else if (snapshot.data.id == "0") {
                  return MyTools.errorWidget(
                    context,
                  );
                }
                secondLoad((this.widget.user == null) ? '' : this.widget.user.id,
                    mitraId: this.widget.mitraId,
                    categoryId: this.widget.categoryId);
                return SafeArea(
                  child: Stack(
                    children: <Widget>[
                      //body
                      _body(context, snapshot.data),
                      //appbar
                      _appBar(context),
                      //button
                      (this.widget.user != null && this.widget.user.levelId == "3") ? Container() : Align(
                        alignment: Alignment.bottomCenter,
                        child: _button(context, snapshot.data),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return MyTools.errorWidget(context,
                    message: "Can't Load Anything!");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  _button(context, ProductDetail result) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(-3, 0),
                blurRadius: 3,
                spreadRadius: 2)
          ]),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              _showBottomSheet(context, result);
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width * (3 / 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15))),
              child: Center(
                  child: Text(
                "Add to Cart",
                style:
                    MyTools.boldStyle(color: MyTools.darkAccentColor, size: 16),
              )),
            ),
          ),
          Builder(
            builder:(context) => GestureDetector(
              onTap: (){
                createCart(result.id, result.userId, this.widget.user.id, qty: 1).then((value) {
                  if(value){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartsPage(user: this.widget.user,)));
                  }else{
                    Scaffold.of(context).showSnackBar(new SnackBar(content: Text("Failed to Add cart", style: MyTools.regular(color: Colors.white, size: 14),)));
                  }
                });
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * (2 / 5),
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15))),
                child: Center(
                    child: Text(
                  "Beli",
                  style: MyTools.boldStyle(color: Colors.white, size: 16),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(context, ProductDetail result) {
    String price = "0";
    if(result.hargaSatuan == "0" ) {
      for (var i in result.hargaZona) {
        for (var j in i.provinsi) {
          if (j.nama == this.widget.user.namaProvinsi) {
            print(i.harga);
            price = i.harga;
//         break;
          }
        }
      }
    }else{
      price = result.hargaSatuan;
    }
    TextEditingController _qty = TextEditingController(text: "1");
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        builder: (context) {
      return StatefulBuilder(
        builder: (context, state) => Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
          height: MediaQuery.of(context).size.height * (1/3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                          result.foto == null ? BaseUrl.baseImage :
                          result.foto[0].foto
                        ),
                      )
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * (1/2) + 20,
                          child: Text(result.nama,maxLines: 2, overflow: TextOverflow.ellipsis, style: MyTools.boldStyle(size: 16, color: MyTools.darkAccentColor),)),
                      Container(
                          width: MediaQuery.of(context).size.width * (1/2) + 20,
                          child: Text("Rp "+MyTools.priceFormat(int.parse(price)), textAlign: TextAlign.left, style: MyTools.boldStyle(size: 15, color: Colors.redAccent),))
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          state((){
                            _qty = TextEditingController(text: (int.parse(_qty.text) + 1).toString());
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 40,
                          child: Icon(Icons.add, size: 15,),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 40,
                        child: TextField(
                          textAlign: TextAlign.center,
                          enabled: false,
                          controller: _qty,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(_qty.text == "1") {
                            state((){
                              _qty = TextEditingController(text: (int.parse(_qty.text) - 0).toString());
                            });
                          }else{
                            state((){
                              _qty = TextEditingController(text: (int.parse(_qty.text) - 1).toString());
                            });
                          }
                        },
                        child: Container(
                          height: 20,
                          width: 40,
                          child: Icon(Icons.remove, size: 15,),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              MaterialButton(onPressed: (){
                createCart(result.id, result.userId, this.widget.user.id, qty: int.parse(_qty.text)).then((value) {

                  if(value){
                    Navigator.pop(context);
                    _skey.currentState.showSnackBar(new SnackBar(content: Text("Berhasil Menambahkan", style: MyTools.boldStyle(size: 16, color: Colors.white)),));
                  }else{
                    Navigator.pop(context);
                    _skey.currentState.showSnackBar(new SnackBar(content: Text("Gagal Menambahkan", style: MyTools.boldStyle(size: 16, color: Colors.white)),));
                  }
                });

              }, height: 45, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ), child: Text("Tambah", style: MyTools.boldStyle(color: Colors.white, size: 16),), color: Colors.red,)
            ],
          ),
        ),
      );
    });
  }

  _body(context, ProductDetail result) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: MyTools.darkAccentColor.withOpacity(0.3),
            height: MediaQuery.of(context).size.height * (2/4),
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3 - 20,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          result.foto.length,
                          (index) => MyTools.imageProvider(
                                result.foto[index].foto,
                                context,
                                height:
                                    MediaQuery.of(context).size.height / 3 - 20,
                                width: MediaQuery.of(context).size.width / 2 - 20,
                              )),
                      controller: controller,
                      onPageChanged: (currentPage) =>
                          setState(() => initialPage = currentPage),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
//                    mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                              result.foto.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Container(
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                          color: (initialPage == index)
                                              ? MyTools.darkAccentColor
                                                  .withOpacity(0.7)
                                              : Colors.black26,
                                          shape: BoxShape.circle),
                                    ),
                                  ))))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          _titleAndPrice(context, result),
          SizedBox(
            height: 10,
          ),
          _productOverview(context, result),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: MyTools.defaultPadding(),
            child: Divider(),
          ),
          _storeInfo(context, {
            'img': result.userFoto,
            'key':result.userNama,
            'value':result.userId
          }),
          SizedBox(
            height: 10,
          ),
          (result.hargaSatuan == '0') ? Padding(
            padding: MyTools.defaultPadding(),
            child: Divider(),
          ) : Container(),
          (result.hargaSatuan == '0') ? _zonePriceList(context, result) : Container(),
          Padding(
            padding: MyTools.defaultPadding(top: 8),
            child: Divider(),
          ),
          _productInformation(context, result),
          SizedBox(height: 10,),
          _otherProduct(context),
          SizedBox(height: 60,),
        ],
      ),
    );
  }

  _zonePriceList(context, ProductDetail result) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10,),
      child: Table(
        border: TableBorder.all(width: 2),
        children: [
          TableRow(
            children: List.generate(result.hargaZona.length, (index) => GestureDetector(
              onTap: (){
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: RichText(text: TextSpan(
                    style: MyTools.regular(color: MyTools.darkAccentColor, size: 14),
                      children: List.generate(result.hargaZona[index].provinsi.length, (ind) => TextSpan(
                          text: result.hargaZona[index].provinsi[ind].nama + ","
                      ))
                  )),
                ));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(result.hargaZona[index].zonaNama, style: MyTools.boldStyle(color: MyTools.darkAccentColor, size: 14)),
                ),
              ),
            ))
          ),
          TableRow(children: List.generate(result.hargaZona.length, (index) => Center(child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("Rp "+MyTools.priceFormat(int.parse(result.hargaZona[index].harga)), style: MyTools.regular(color: MyTools.darkAccentColor, size: 14),),
          ))))
        ],
      ),
    );
  }

  _otherProduct(context) {
    return Container(
      height: MediaQuery.of(context).size.width * (2 / 4),
      width: double.infinity,
      child: StreamBuilder<ProductModeltwo>(
          stream: bloc?.products,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return MyTools.errorWidget(context);
            } else if (snapshot.hasData) {
              return Center(child: _listProductFromCategory(snapshot.data.data[0]));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  _titleAndPrice(context, ProductDetail result) {
    var price = "0";
    if (result.hargaSatuan == '0' && this.widget.user != null) {
      for (var i in result.hargaZona) {
        for (var j in i.provinsi) {
          if (j.nama == this.widget.user.namaProvinsi) {
            print(i.harga);
            price = i.harga;
//         break;
          }
        }
      }
    } else {
      price = result.hargaSatuan;
    }
    return Padding(
      padding: MyTools.defaultPadding(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * (2 / 3) - 10,
            child: Text(
              result.nama,
              style:
                  MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
            ),
          ),
          Container(
//          color: Colors.black,
            width: MediaQuery.of(context).size.width * (1 / 3) - 10,
            child: (this.widget.user == null) ? Container() : Text(
              "Rp " + MyTools.priceFormat(int.parse(price)),
              style: MyTools.boldStyle(size: 17, color: MyTools.redColor),
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }

  _storeInfo(context, Map<String, dynamic> result) {

    /**
     * img = image,
     * key = store name,
     * value = store id
     */

    return ListTile(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMitraPage(
        user: this.widget.user,
        mitraId: result['value'],
      ))),
      leading: CircleAvatar(
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(result['img']),
              fit: BoxFit.cover,
          )
          ),
        ),
        backgroundColor: MyTools.primaryColor,
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * (1/2) + 20,
              child: Text(result['key'], style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),)),
        ],
      ),
      trailing: Icon(Icons.check_circle, size: 25, color: Colors.amberAccent),
    );
  }

  _productOverview(context, ProductDetail result) {
    return Padding(
      padding: MyTools.defaultPadding(),
      child: Container(
        width: double.infinity,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _iconOverview(context, Icons.visibility,
                msg: "Dilihat", value: result.dilihat),
            _iconOverview(context, Icons.access_time,
                msg: "Kondisi", value: result.kondisi),
            _iconOverview(context, Icons.local_shipping,
                msg: "Terkirim", value: result.terkirim),
            _iconOverview(context, Icons.local_offer,
                msg: "Min. Pembelian", value: result.pembelianMinimum)
          ],
        ),
      ),
    );
  }

  _productInformation(context, ProductDetail result) {
    return Padding(
      padding: MyTools.defaultPadding(),
      child: Container(
        child: HtmlWidget(
          result.deskripsi,
          textStyle: MyTools.regular(
              size: 14, color: MyTools.darkAccentColor.withOpacity(0.8)),
        ),
      ),
    );
  }

  _iconOverview(context, IconData icon, {String msg, String value}) {
    var val = (value == null) ? "0" : value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "$msg : $val",
          style: MyTools.regular(color: MyTools.darkAccentColor, size: 14),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  _appBar(context) {
    return Container(
      height: 60,
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyTools.darkAccentColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: MyTools.darkAccentColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: MyTools.darkAccentColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  _listProductFromCategory(Datum category) {
    if(category.produk == null) {
      return Container();
    }
    return Container(
      height: 180,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3)
      ]),
      child: Container(
//        height: 200,
        child: ListView.builder(
          itemCount: category?.produk?.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration:
                        Duration(milliseconds: 350),
                        pageBuilder: (context, _, __) => ProductDetailPage(
                            mitraId: category.produk[index].userId,
                            categoryId: category.id,
                            user: this.widget.user,
                            productId: category.produk[index].id))),
                child: Container(
                  width: 130,
//                  height: 180,
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Container(
                          child: (category.produk[index].foto != null) ? MyTools.imageProvider(category.produk[index].foto[0].foto, context) : Image.network('http://siplah.mascitra.co.id/assets/images/no-image.png',
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5.0)
                              ]),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        width: 110,
                        child: Text(
                          category.produk[index].produk,
                          style: MyTools.regular(size: 12, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 110,
//                        height: 50,
                        child: Text(
                          category.produk[index].harga != '0'
                              ? "Rp " + category.produk[index].harga
                              : "harga zona",
                          style: MyTools.boldStyle(size: 14, color: Colors.redAccent),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
