import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_detail_state.dart';
import 'package:siplah_jpmall/src/models/mitra_detail_model.dart';
import 'package:siplah_jpmall/src/models/product_mitra.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/resources/products_provider.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class DetailMitraPage extends StatefulWidget {
  final UserData user;
  final String mitraId;

  const DetailMitraPage({Key key, @required this.user, this.mitraId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => DetailMitraPageState();
}

class DetailMitraPageState extends State<DetailMitraPage>
    with MitraDetailState {
  Widget _widgetReach = CircularProgressIndicator();
  final bloc = MitraBloc();
  List<Products> productsMitra = [];
  int page = 1;
  ScrollController controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    firstLoad(this.widget.mitraId);
    ProductProvider()
        .fetchProductMitra(this.widget.mitraId, page: page)
        .then((value) {
          if(value.data == null || value.data.length == 0) {
            _widgetReach = Text("Tidak Ada lagi", style: MyTools.regular(size: 14,color: MyTools.darkAccentColor),);
          }else{
            setState(() => productsMitra.addAll(value.data));
          }
    });
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() {
          page += 1;
        });
        ProductProvider()
            .fetchProductMitra(this.widget.mitraId, page: page)
            .then((value) {
              if(value == null || value.data == null || value.data.length == 0) {
                setState(() {
                  _widgetReach = Text("Tidak Ada lagi", style: MyTools.regular(size: 14,color: MyTools.darkAccentColor),);
                });
              }else{
                setState(() => productsMitra.addAll(value.data));
              }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder<MitraDetailModel>(
        stream: bloc.mitraProfile,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                body: MyTools.errorWidget(context,
                    message: "Error, can't load this page"));
          } else if (snapshot.hasData) {
            if (snapshot.data.error) {
              return Scaffold(
                  body: MyTools.errorWidget(context,
                      message: snapshot.data.pesanUsr));
            }
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: _appBar(context, snapshot.data),
              body: SingleChildScrollView(
                controller: controller,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    _storeInfo(context, snapshot.data),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Divider(),
                    ),

                    GridView.count(
                      childAspectRatio: height/width < 2 ? 0.8 : 0.85,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                          productsMitra.length,
                          (index) => _listProducts(context, productsMitra[index])),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Center(child: _widgetReach),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }

  _appBar(context, MitraDetailModel result) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 40,
        width: MediaQuery.of(context).size.width * (1 / 2) + 20,
        decoration: BoxDecoration(
          color: Colors.black12.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Cari Produk",
              style: MyTools.regular(color: MyTools.darkAccentColor, size: 14),
            ),
            Icon(
              Icons.search,
              color: MyTools.darkAccentColor,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: MyTools.darkAccentColor,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartsPage(
                          user: this.widget.user,
                        )))),
        IconButton(
            icon: Icon(
              Icons.info,
              color: MyTools.darkAccentColor,
            ),
            onPressed: () {}),
      ],
    );
  }

  _listProducts(context, Products result ) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                mitraId: result.userId,
                user: this.widget.user,
                categoryId: result.kategoriId,
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
  _storeInfo(context, MitraDetailModel result) {
    return Container(
//      padding: MyTools.defaultPadding(),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Container(
              height: 70,
              width: 70,
              child: Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 50,
                    minRadius: 50,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(result.data[0].foto ?? BaseUrl.baseImage),
                            fit: BoxFit.cover,
                          )),
                    ),
                    backgroundColor: MyTools.primaryColor,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.amberAccent,
                      )),
                ],
              ),
            ),
            title: Container(
                width: MediaQuery.of(context).size.width * (1 / 2) + 20,
                child: Text(
                  result.data[0].nama,
                  style: MyTools.boldStyle(
                      size: 18, color: MyTools.darkAccentColor),
                )),
            subtitle: GestureDetector(
              onTap: () => openMaps(double.parse(result.data[0].latitude),
                  double.parse(result.data[0].longitude)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        result.data[0].provinsiNama,
                        style: MyTools.regular(
                            color: MyTools.darkAccentColor, size: 13),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.open_in_new,
                        color: MyTools.darkAccentColor,
                        size: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.store,
                        color: MyTools.darkAccentColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          width:
                              MediaQuery.of(context).size.width * (1 / 2) + 20,
                          child: Text(
                            result.data[0].alamat,
                            style: MyTools.regular(
                                color: MyTools.darkAccentColor, size: 13),
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            child: result.data[0].deskripsi == null ? null : RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: (result.data[0].deskripsi.length < 50) ? result.data[0].deskripsi : (isExpanded1)
                        ? result.data[0].deskripsi
                            : result.data[0].deskripsi.substring(0, 50),
                    style: MyTools.regular(
                        size: 13, color: MyTools.darkAccentColor)),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () => changeExpanded1(),
                    text: (result.data[0].deskripsi.length < 50)
                        ? ''
                        : (isExpanded1) ? " Lebih Sedikit" : " Lebih banyak.",
                    style: MyTools.boldStyle(size: 12, color: Colors.redAccent))
              ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  DetailMitraPageState createState() => this;
}
