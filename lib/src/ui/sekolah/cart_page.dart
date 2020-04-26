import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/bloc/cart/cart_bloc.dart';
import 'package:siplah_jpmall/src/bloc/cart/cart_state.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/sekolah/my_order_detail_page.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class CartPage extends StatefulWidget {
  final UserData user;

  const CartPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => CartPageState();
}

class CartPageState extends State<CartPage> with CartState {
  final bloc = CartBloc();

  @override
  void initState() {
    super.initState();
    firstLoad(this.widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: MyTools.primaryColor,
        title: Text(
          "Keranjang",
          style: MyTools.boldStyle(size: 18, color: Colors.white),
        ),
      ),
      body: StreamBuilder<CartModel>(
        stream: bloc.cart,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MyTools.errorWidget(context,
                message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            if (snapshot.data.error) {
              return MyTools.errorWidget(context,
                  message: snapshot.data.pesanUsr);
            } else if (snapshot.data.data == null) {
              return MyTools.errorWidget(context,
                  message: "Keranjang Kamu Masih kosong !");
            }
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            snapshot.data.data.length,
                            (index) =>
                                _customTile(context, snapshot.data.data[index])),
                      ),
                      SizedBox(height: 60,)
                    ],
                  ),
                ),
                _button(context, snapshot.data)
              ],
            );
          }
          return MyTools.loadingWidget;
        },
      ),
    );
  }

  _button(context, CartModel result) {
    List<String> ids = [];
    int harga = 0;
    result.data.forEach((e) {
      e.produk.forEach((element) {
        ids.add(element.id);
        harga += (int.parse(element.produkHarga) * int.parse(element.jumlah));
      });
    });
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(5, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120,
              padding: const EdgeInsets.only(
                left: 10
              ),
              child: RichText(
                text: TextSpan(
                  style: MyTools.regular(size: 12, color: MyTools.darkAccentColor),
                  children:[
                    TextSpan(
                      text: "Total Harga :\n"
                    ),
                    TextSpan(
                      text: "Rp" + MyTools.priceFormat(harga),
                      style: MyTools.regular(size: 13, color: Colors.redAccent)
                    )
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MaterialButton(
                onPressed: (){
                  createPayment(this.widget.user.id, ids, result);
                },
                color: Colors.green,
                child: Text("Lanjut Ke Pemesanan", style: MyTools.regular(size: 12, color: Colors.white),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _customTile(context, Datum result) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4, top: 4),
      child: GestureDetector(
//        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderDetailPage(user: this.widget.user, id: result.,))),
        child: Container(
          padding: MyTools.defaultPadding(bottom: 8),
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
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  result.foto ?? BaseUrl.baseImage))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            child: Text(
                              result.nama.length < 25
                                  ? result.nama
                                  : result.nama.substring(0, 25),
                              style: MyTools.boldStyle(
                                  size: 12, color: MyTools.darkAccentColor),
                            ),
                            width: MediaQuery.of(context).size.width * (1 / 2) +
                                30),
                        Container(
                            child: Text(
                              result.kabupatenNama,
                              style: MyTools.regular(
                                  size: 11, color: MyTools.darkAccentColor),
                            ),
                            width: MediaQuery.of(context).size.width * (1 / 2) +
                                30),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(result.produk.length, (index) {
                  TextEditingController _qty =
                      TextEditingController(text: result.produk[index].jumlah);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 2,
                            color: MyTools.darkAccentColor.withOpacity(0.5)),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(result
                                                  .produk[index]
                                                  .produkFoto[0]
                                                  .foto ??
                                              BaseUrl.baseImage))),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      result.produk[index].produkNama.length <
                                              25
                                          ? result.produk[index].produkNama
                                          : result.produk[index].produkNama
                                                  .substring(0, 25) +
                                              "...",
                                      style: MyTools.boldStyle(
                                          size: 12,
                                          color: MyTools.darkAccentColor),
                                    ),
                                    Text(
                                      "Rp " +
                                          MyTools.priceFormat(int.parse(result
                                              .produk[index].produkHarga)),
                                      style: MyTools.regular(
                                          color: Colors.redAccent, size: 11),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    int qty =
                                        int.parse(result.produk[index].jumlah) +
                                            1;
                                    update(result.produk[index].id,
                                        this.widget.user.id,
                                        qty: qty);
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1,
                                            color: MyTools.darkAccentColor)),
                                    child: Icon(Icons.add,
                                        size: 15,
                                        color: MyTools.darkAccentColor),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 30,
                                  child: TextField(
                                    style: MyTools.regular(
                                        size: 12,
                                        color: MyTools.darkAccentColor),
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    controller: TextEditingController(
                                        text: result.produk[index].jumlah),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (result.produk[index].jumlah == "1") {
                                    } else {
                                      int qty = int.parse(
                                              result.produk[index].jumlah) -
                                          1;
                                      update(result.produk[index].id,
                                          this.widget.user.id ?? "74",
                                          qty: qty);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1,
                                            color: MyTools.darkAccentColor)),
                                    height: 20,
                                    width: 40,
                                    child: Icon(Icons.remove,
                                        size: 15,
                                        color: MyTools.darkAccentColor),
                                  ),
                                ),
                                Spacer(flex: 1),
                                GestureDetector(
                                  onTap: () {
                                    delete(result.produk[index].id,
                                        this.widget.user.id);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.red)),
                                    height: 20,
                                    width: 40,
                                    child: Icon(Icons.delete_outline,
                                        size: 15, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  CartPageState createState() => this;
}
