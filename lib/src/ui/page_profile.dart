import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
//import 'package:provider/provider.dart';
import 'package:siplah_jpmall/src/bloc/settings/setting_bloc.dart';
import 'package:siplah_jpmall/src/bloc/settings/setting_state.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/setting_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
//import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/alamatpemesan.dart';
import 'package:siplah_jpmall/src/ui/edit_profilSKLH.dart';
import 'package:siplah_jpmall/src/ui/edit_profile.dart';
import 'package:siplah_jpmall/src/ui/imagecabang.dart';
import 'package:siplah_jpmall/src/ui/komplain.dart';
import 'package:siplah_jpmall/src/ui/komplain_mitra.dart';
import 'package:siplah_jpmall/src/ui/marketing.dart';
import 'package:siplah_jpmall/src/ui/penjualan.dart';
import 'package:siplah_jpmall/src/ui/pesanan.dart';
import 'package:siplah_jpmall/src/ui/produk_favorit.dart';
import 'package:siplah_jpmall/src/ui/rekomtoko.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';
import 'footer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:siplah_jpmall/src/ui/tambahcabang.dart';

import 'login.dart';

class ProfilePage extends StatefulWidget {
  final UserData user;

  const ProfilePage({Key key, this.user, }) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with SettingState {
  final bloc = SettingBloc();
  double position = 0;
  @override
  void initState() {
    super.initState();
    if(this.widget.user != null){firstLoad();}
  }



  List data, data2;
  Future<String> getJsonData() async {
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/blog/blog_footer'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
    );
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      data2 = convertDataToJson['Data'][0]['page'];
    });
  }

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
    return Scaffold(
      appBar: _appBar(context),
      body: StreamBuilder<ResultSetting>(
        stream: bloc.setting,
          builder: (context, snapshot) {
          if(snapshot.hasError){
           return Center(child: Text("Can't Load Data"),);
          }else if(snapshot.hasData){
            if(snapshot.data.error){
              showAlert(snapshot.data.pesanUsr);
            }
            return _body(context, snapshot.data);
          }return Center(child: CircularProgressIndicator());
          }),
      drawer: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            this.widget.user.levelId != '3'
                ? Column(children: <Widget>[
              SizedBox(
                width: 300,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      image: new DecorationImage(
                        //src/image/Icons_SIPLAH_JPSTORE_2020.png
                          image: new AssetImage(
                            "src/image/Icons_SIPLAH_JPSTORE_2020.png",
                          ))),
                ),
              ),
              ListTile(
                title: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Profil'),
                      ],
                    )),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditprofileSKL(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.shopping_basket,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Pesanan'),
                    ],
                  ),
                ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PesananState(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.local_shipping,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Alamat Pengiriman'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AlamatPemesan(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.comment,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Komplain'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            KomplainSekolah(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Produk Favorit'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProdukFavorit(user: this.widget.user,),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                onTap: () {
//                  showAlert();
                },
              ),
            ])
                : Column(children: <Widget>[
              SizedBox(
                width: 380,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      image: new DecorationImage(
                          image: new AssetImage(
                              "src/image/Icons_SIPLAH_JPSTORE_2020.png"))),
                ),
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Profil'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Editprofile(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.store_mall_directory,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Penjualan'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Penjualan(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.people_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Cabang Mitra'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            TambahCabang(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.comment,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Komplain'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            KomplainMitra(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.local_convenience_store,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Marketing'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Marketing(),
                      ));
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                onTap: () {
//                  showAlert(context);
                },
              ),
            ])
          ],
        ),
      ),
    );
  }
  _body(BuildContext context, ResultSetting snapshot){
    final result = snapshot.data;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),
          //
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(result.length, (index) => ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(result[index].nama, style: TextStyle(fontWeight: FontWeight.w500),),
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(result[index].page.length, (i) => Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: BorderSide(
                      color: Colors.black54,
                      width: 2,
                    )),
                    child: ListTile(
                      title: Text(result[index].page[i].judul, style: TextStyle(fontWeight: FontWeight.w500),),
                    ),
                  ),
                )),
              ),
            )),
          )
        ],
      ),
    );
  }
    _appBar(BuildContext context) {
      return AppBar(
        backgroundColor: Colors.blue[800],
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                child: Center(
                  child: Image.network(
                      (this.widget.user.foto == null)
                        ? 'http://siplah.mascitra.co.id/assets/images/user.ico'
                        : this.widget.user.foto,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(
                    this.widget.user.nama != null ? this.widget.user.nama : "waiting...",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      );
    }

    @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  ProfilePageState createState() => this;
}

class PagesiteA extends StatefulWidget {
  final String id;

  const PagesiteA({Key key, this.id}) : super(key: key);

  @override
  _PageSiteA createState() => _PageSiteA();
}

class _PageSiteA extends State<PagesiteA> {
  @override
  void initState() {
    getJsonData();
  }

  List data, data2;
  Future<String> getJsonData() async {
    //print(widget.id);
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/blog/tampil'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {'id': widget.id},
    );
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Data'];
      //print(data[0]['judul']);
    });
  }

  //String a;
  @override
  Widget build(BuildContext context) {
    //a=a+data[0]['judul'];
    return data == null
        ? Scaffold()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: new Text(
                "" + data[0]['judul'],
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: HtmlWidget(
                  data[0]['content'],
                ),
              ),
            ),
          );
  }
}

class PagesiteB extends StatefulWidget {
  final String id;

  const PagesiteB({Key key, this.id}) : super(key: key);

  @override
  _PageSiteB createState() => _PageSiteB();
}

class _PageSiteB extends State<PagesiteB> {
  @override
  void initState() {
    getJsonData();
  }

  List data2;
  Future<String> getJsonData() async {
    //print(widget.id);
    var response = await http.post(
      //Encode the url
      Uri.encodeFull('http://siplah.mascitra.co.id/api/blog/tampil'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "API-App": "siplah_jpmall.id",
        "Api-Key": "4P1_7Pm411_51p114h",
        "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
      },
      body: {'id': widget.id},
    );
    //print(response.body);
    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data2 = convertDataToJson['Data'];
      //print(data[0]['judul']);
    });
  }

  //String a;
  @override
  Widget build(BuildContext context) {
    //a=a+data[0]['judul'];
    return data2 == null
        ? Scaffold()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: new Text(
                "" + data2[0]['judul'],
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: HtmlWidget(
                  "" + data2[0]['content'],
                ),
              ),
            ),
          );
  }
}
//   _bantuan(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Text(
//           "Transaksi",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Container(
//           height: 50,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "Pusat Bantuan",
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black87),
//               ),
//               Text(
//                 "Lihat solusi terbaik atau hubungi kami",
//                 style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black45),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   _transaksi(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Text(
//           "Transaksi",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: _listTr.map((f) {
//             return InkWell(
//               onTap: () {},
//               child: Container(
//                 height: 50,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       f.title,
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black87),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       f.sub,
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black45),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//         SizedBox(
//           height: 4,
//         ),
//         _daftarTransaksi(context),
//       ],
//     );
//   }

//   _daftarTransaksi(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Text(
//           "Daftar Transaksi",
//           style: TextStyle(
//               fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Icon(
//                     Icons.shop,
//                     size: 50,
//                     color: Colors.cyan,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "Belanja",
//                     style: TextStyle(fontSize: 15),
//                   )
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   Icon(
//                     Icons.shop,
//                     size: 50,
//                     color: Colors.cyan,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "Belanja",
//                     style: TextStyle(fontSize: 15),
//                   )
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   Icon(
//                     Icons.shop,
//                     size: 50,
//                     color: Colors.cyan,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "Belanja",
//                     style: TextStyle(fontSize: 15),
//                   )
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   Icon(
//                     Icons.shop,
//                     size: 50,
//                     color: Colors.cyan,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "Belanja",
//                     style: TextStyle(fontSize: 15),
//                   )
//                 ],
//               ),
//             ])
//       ],
//     );
//   }

_favoriteSaya(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        "Favorit Saya",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _listFav.map((f) {
          return Container(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  f.title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  f.sub,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45),
                ),
              ],
            ),
          );
        }).toList(),
      ),
//        _raihCashBack(context)
    ],
  );
}

class Tr {
  final int index;
  final String title;
  final String sub;

  Tr(this.index, this.title, this.sub);
}

class Fav {
  final int index;
  final String title;
  final String sub;

  Fav(this.index, this.title, this.sub);
}

List<Tr> _listTr = <Tr>[
  Tr(0, "Menunggu Pembayaran", "Semua Transaksi yang belum dibayar"),
  Tr(1, "Ulasan", "Berikan penilaian dan ulasan Produk"),
  Tr(2, "Komplain Sebagain Pembeli", "Lihat Status komplain"),
];
List<Fav> _listFav = <Fav>[
  Fav(0, "Topik Favorit", "Atur Topik favorit anda"),
  Fav(1, "Terakhir Dilihat", "Cek Produk yang dilihat"),
  Fav(2, "Wishlist", "Lihat Produk yang sudah anda wishlist"),
  Fav(3, "Toko Favorit", "Lihat Toko yang sudah anda favoritkan"),
  Fav(4, "Langganan", "Atur dan bayar tagihan dalam satu tempat"),
];

class PageJual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.shop_two,
            size: 150,
            color: Colors.cyan,
          ),
          Text(
            "Buat Toko anda sekarang",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black45,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          MaterialButton(
              color: Colors.cyan,
              child: Text(
                "Buat Toko",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}
