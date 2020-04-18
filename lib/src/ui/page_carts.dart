import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/bloc/cart/cart_bloc.dart';
import 'package:siplah_jpmall/src/bloc/cart/cart_state.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/auth/login_page.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:siplah_jpmall/src/ui/pembayaran.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';
import 'globals.dart' as globals;

class CartsPage extends StatefulWidget {
  final UserData user;

  const CartsPage({Key key, this.user}) : super(key: key);
  @override
  CartsPageState createState() => CartsPageState();
}

class CartsPageState extends State<CartsPage> with CartState {
  final CartBloc bloc = new CartBloc();
  List<bool> itemSelected = [];
  bool checkedAll = true;
  int priceTotal = 0;

  @override
  CartsPageState createState() => this;

  int totalharga = 0;
  int load = 0;
  bool check = false;
  int akhirtotal = 0;
  List<int> _subtotal = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<bool> _check = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final formatter = new NumberFormat("#,###");
  Future<http.Response> _delete(String idx) async {
    //a=a+id;
    //print(id);
    var url = 'http://siplah.mascitra.co.id/api/sekolah/keranjang/delete';

    Map data = {'user_id': "" + id, 'id': idx};
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
    print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
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
              content: Text("Data berhasil diubah"),
            ));
  }

  void totalmethod(int a) {
    getJsonData();
    totalharga = totalharga + a;
    load = 1;
  }

  Future<http.Response> qtyjson(String id_produk, String jumlah_produk) async {
    //a=a+id;
    //print(id);
    var url = 'http://siplah.mascitra.co.id/api/sekolah/keranjang/set_stok';

    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "API-App": "siplah_jpmall.id",
      "Api-Key": "4P1_7Pm411_51p114h",
      "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
    }, body: {
      "id": id_produk,
      "jumlah": jumlah_produk,
    });
    // print("${response.statusCode}");

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    print(map);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      // savedata();
      getJsonData();
    }
    return response;
  }

  var linkimage = "http://cahyamotor.co.id/images/empty-cart-icon.jpg";

  var item = false;
  ScrollController _controllerProduk;
  TextEditingController _qty;

  @override
  void initState() {
    _controllerProduk = ScrollController();
    super.initState();
    if (this.widget.user != null) {
      firstLoad(this.widget.user.id);
    }
  }

  List datatrans;
  int idtrans;

  Future<http.Response> daftartransaksi(keranjang) async {
    var url = 'http://siplah.mascitra.co.id/api/sekolah/pembayaran/tambah';
    Map keranjangid = {"id": keranjang};
    // Map keranjangid ={
    //   "id":keranjang
    // };\

    var myList = List(data2.length);
    var i = 0;
    void main() {
      while (i < data2.length) {
        var a = data2[i]['id'];
        myList[i] = {'id': a};
        i++;
      }
      print(myList);
    }

    main();
    //Map data = {"id": keranjang};
    var cart = json.encode(myList);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "07decd51d9e8c78fd86ce065e710e0084f6a265f"
      },
      body: {"user_id": id, "keranjang_id": cart},
    );
    //print("${response.statusCode}");
    print(cart);
    print("${response.body}");

    Map<String, dynamic> map = jsonDecode(response.body);
    // var response = await http.post(
    //   //Encode the url
    //   Uri.encodeFull('http://siplah.mascitra.co.id/api/sekolah/pembayaran/tambah'),

    //   headers: {
    //     "Content-Type": "application/x-www-form-urlencoded",
    //     "API-App": "siplah_jpmall.id",
    //     "Api-Key": "4P1_7Pm411_51p114h",
    //     "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
    //   },
    //   body: {
    //     "user_id": id,
    //     "keranjang_id":
    //     {"id":keranjang}
    //   },
    // );
    // // print("${response.statusCode}");

    // print("${response.body}");
    // Map<String, dynamic> map = jsonDecode(response.body);
    //print(map['Data']['transaksi_id']);
    if (map["Error"] == true || map["Error"] == "true") {
      _showAlert(context);
    } else {
      setState(() {
        //Map<String, dynamic> map1 = jsonDecode(response.body);
        int payment_code = map['Data']['transaksi_id'];
        idtrans = payment_code;
        idtrans == null
            ? print(payment_code)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PembayaranState(totalharga: totalharga, idtrans: idtrans),
                ));
      });
    }
    return response;
  }

  List data;
  List data2;
  String keranjang;
  Future<String> getJsonData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/sekolah/keranjang/isi'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {
        "user_id": id,
      },
    );
    // print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      data2 = convertDataToJson['Data'][0]['Produk'];
      keranjang = data2[0]['id'];
    });

    return "Success";
  }

  void _showAlert1(BuildContext context, String idx) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text("Yakin Mau Menghapus"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _delete(idx);
                    }),
              ],
            ));
  }

  String nama;
  String namauser;
  String level_id;
  String foto;
  String id;
  getCredential() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      namauser = pref.getString("username");
      nama = pref.getString("nama");
      level_id = pref.getString("level_id");
      foto = pref.getString("foto");
      id = pref.getString('id');
    });
    getJsonData();
  }

  var qtyjumlah = 0;

  @override
  Widget build(BuildContext context) {
    if (this.widget.user == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyTools.errorWidget(context,
                  message: "Upss!. Kamu Belum Login, Login Dulu Yuk ! "),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 40,
                minWidth: 120,
                color: Colors.redAccent,
                child: Text("Login Disini", style: MyTools.boldStyle(color: Colors.white, size: 15),),
              )
            ],
          ),
        ),
      );
    }

    return Container(
      child: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            flexibleSpace:
                Container(decoration: BoxDecoration(color: MyTools.primaryColor)),
            actions: <Widget>[
              Center(
                child: Text("hapus"),
              ),
              SizedBox(
                width: 10,
              )
            ],
            automaticallyImplyLeading: false,
            title: Text(
              "Keranjang",
              style: TextStyle(color: Colors.white),
            ),
            bottom: PreferredSize(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                        value: checkedAll,
                        onChanged: (value) {
                          if (itemSelected.length != 0) {
                            List<bool> newItem = [];
                            itemSelected.forEach((i) {
                              setState(() => newItem.add(value));
                            });
                            setState(() {
                              checkedAll = value;
                              itemSelected = newItem;

                              if (value) {
                                print("this value is true");
//                                priceTotal = priceTotal + int.parse()
                              } else {
                                print("this value is false");
                              }
                            });
                          }
                        }),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Pilih Semua",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              preferredSize: Size(double.infinity, 50),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black12, offset: Offset(0, -3))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: Main,
                  children: <Widget>[
                    Text("Total Harga"),
                    Text(
                      'Rp . ' + formatter.format(priceTotal),
                      style: TextStyle(fontSize: 14, color: Colors.cyan),
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      //   print(keranjang);
                      daftartransaksi(keranjang);
                      //print(idtrans);
                      //  idtrans==null? print(idtrans):
                      //  Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (BuildContext context) =>
                      //                   PembayaranState(totalharga:totalharga,
                      //                   ),
                      //             ));
                    },
                    child: Container(
                      height: 38,
                      width: 100,
                      color: Colors.cyan,
                      child: Center(
                          child: Text(
                        "Beli",
                        style: TextStyle(color: Colors.white),
                      )),
                    )),
              ],
            ),
          ),
          body: StreamBuilder<CartModel>(
              stream: bloc.cart,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error, cant Load this Content"),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data.error) {
                    return Center(
                      child: Text("Error, This content is Unavailable"),
                    );
                  }
                  return _itemada(context, snapshot.data);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }

  _itemada(BuildContext context, CartModel snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              child: Icon(
                Icons.insert_emoticon,
                size: 40,
                color: Colors.blue,
              ),
            ),
            Text("Your Cart is Empty"),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(snapshot.data.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    // toko
                    // mainAxisAlignment: MainAxis,
                    children: <Widget>[],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    // produk
                    child: ListView.builder(
                      controller: _controllerProduk,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data[index].produk.length,
                      itemBuilder: (context, i) {
                        // final y = x.produk[i];

                        final x = snapshot.data[index].produk;
//                        String a = 'aku';
                        int totalqty = int.parse(x[i].jumlah);
//                        bool aktif = false;

//                        qtyjumlah = int.parse(x[i].jumlah);
//                        int harga3 = x[i].subTotal;
//                        _subtotal[i] = harga3;
//                        print(_subtotal);

                        priceTotal = priceTotal + int.parse(x[i].produkHarga);
                        _qty = TextEditingController(text: totalqty.toString());
                        itemSelected.add(false);
                        return Column(
                          // produk
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              // title
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  child: Checkbox(
                                    value: itemSelected[index],
                                    onChanged: (value) {
                                      setState(() {
                                        itemSelected[index] = value;
//                                            if(value) {
//                                              priceTotal = priceTotal + int.parse(snapshot.data[index].produk[i].produkHarga);
//                                              print(priceTotal);
//                                            }else {
//                                              priceTotal = priceTotal - int.parse(snapshot.data[index].produk[i].produkHarga);
//                                              print(priceTotal);
//                                            }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(x[i].produkFoto != null
                                        ? x[i].produkFoto[0].foto
                                        : 'http://siplah.mascitra.co.id/assets/images/no-image.png')),
                                Column(
                                  // mainAxisAlignment: ,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 250,
                                        child: Text(
                                          x[i].produkNama,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    Container(
                                        child: Text(
                                            "Rp " +
                                                MyTools.priceFormat(int.parse(
                                                    x[i].produkHarga)),
                                            style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.cyan,
                                            )))
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    showAlert1(
                                        context, x[i].id, this.widget.user.id);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              //favorite & qty
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 13,
                                          )
                                        ]),
                                    child: Center(
                                        child: Icon(
                                      Icons.favorite_border,
                                      size: 20,
                                    ))),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          var counteree = int.parse(_qty.text);
                                          int add = counteree + 1;

                                          qtyjson(x[i].id, add.toString());
                                        },
                                        child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all()),
                                            child:
                                                Center(child: Icon(Icons.add))),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 30,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: _qty,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var counteree = int.parse(_qty.text);
                                          int add = counteree - 1;

                                          qtyjson(x[i].id, add.toString());
                                        },
                                        child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all()),
                                            child: Center(
                                                child: Icon(Icons.remove))),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // Text("Tulis Catatan untuk Toko", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.w500),),
                            SizedBox(
                              height: 15,
                            ),
                            // _controllerProduk.offset != _controllerProduk.position.maxScrollExtent ?  Container() :   Divider()
                          ],
                        );
                      },
                    ),
                  ),
                  // _listk.length <= 1 ? Container() : customDivider()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  customDivider() {
    return Container(
      height: 10,
      width: double.infinity,
      color: Colors.black12,
      // child: ,
    );
  }

  _itemkosong(BuildContext context) {
    return Container(
      // color:,
      // height: 200,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(height: 150, width: 230, child: Image.network(linkimage)),
          SizedBox(
            height: 10,
          ),
          Text("Keranjang Belanja Kosong",
              style: TextStyle(color: Colors.black26, fontSize: 13)),
          SizedBox(
            height: 10,
          ),
          // Text("Wujudkan Impian di Wishlist Kamu")
          Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.cyan,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 1))
                ]),
            child: Center(
              child: Text(
                "Belanja Sekarang",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
