import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/home/home_bloc.dart';
import 'package:siplah_jpmall/src/bloc/home/home_state.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/recomened_products_model.dart';
import 'package:siplah_jpmall/src/models/slide_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/gridkategori.dart';
import 'package:siplah_jpmall/src/ui/imageslider.dart';
import 'package:siplah_jpmall/src/ui/myappbar.dart';
import 'package:siplah_jpmall/src/ui/myflexspace.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

import 'kategori.dart';

class HomePage extends StatefulWidget {
  final UserData user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with HomeState {
  HomeBloc bloc = HomeBloc();
  UserData user;
  List<RcData> listRc = [];
  int page = 1;
  @override
  HomePageState createState() => this;

  double posisi = 0.0;
  int currentPage = 0;
  ScrollController _controller;

  _scrollListener() {
    setState(() {
      posisi = _controller.offset;
    });
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        page += 1;
        bloc.getRP(this.widget.user == null ? '' : this.widget.user.id, page: page).then((value) => (value != null) ? listRc.addAll(value.data) : null);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    firstLoad((this.widget.user != null) ? this.widget.user.id : '');
    bloc.getRP(this.widget.user == null ? '' : this.widget.user.id, page: page).then((value) => (value != null) ? listRc.addAll(value.data) : null);
//    print(this.widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (context, inner) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    firstChild: MyAppBarNormal(),
                    secondChild: MyAppBarAbNormal(),
                    crossFadeState: posisi <= 27
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstCurve: Curves.bounceIn,
                    secondCurve: Curves.bounceInOut),
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: Container(
                  decoration: BoxDecoration(color: MyTools.primaryColor),
                  child: FlexibleSpaceBar(
                    background: MyFlexSpace(),
                  ),
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () =>
                firstLoad(this.widget.user == null ? '' : this.widget.user.id),
            child: StreamBuilder<ProductModeltwo>(
                stream: bloc.homeContent,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return MyTools.errorWidget(context,
                        message: snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    if (snapshot.data.error) {
                      return MyTools.errorWidget(context,
                          message: snapshot.data.pesanUsr);
                    }
                    load();
                    return SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<SlideModel>(
                            stream: bloc.slide,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Container(
                                  height: 100,
                                  child: MyTools.errorWidget(context,
                                      message: snapshot.error.toString()),
                                );
                              } else if (snapshot.hasData) {
                                if (snapshot.data.error) {
                                  return Container(
                                    height: 100,
                                    child: MyTools.errorWidget(context,
                                        message: snapshot.data.pesanUsr),
                                  );
                                } else if (snapshot.data.data.length == 0) {
                                  return Container(
                                    height: 100,
                                    child: MyTools.errorWidget(context,
                                        message: "Data Tidak Ada"),
                                  );
                                }
//                                print(snapshot.data.pesanUsr);
                                return _imageSlider(context, snapshot.data);
                              }
                              return Container(
                                height: 100,
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _category(context, snapshot.data),
                          SizedBox(
                            height: 8,
                          ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(width: 80, height: 1, color: Colors.grey,),
                                  ),
                                  Container(child: Text("Produk Rekomendasi", style: MyTools.boldStyle(color: MyTools.darkAccentColor, size: 16),)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(width: 80,  height: 1, color: Colors.grey,),
                                  ),
                                ],
                              ),
                              GridView.count(
                                childAspectRatio: height/width < 2 ? 0.8 : 0.85,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,children: List.generate(listRc.length, (index) => _listProducts(context, listRc[index])),)
                        ]));
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )),
    );
  }

  _imageSlider(context, SlideModel slider) {
    int currentSlide = 1;
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: Duration(seconds: 10),
            reverse: false,
            enableInfiniteScroll: true,
            initialPage: currentPage,
            aspectRatio: 16 / 9,
            items: List.generate(
                slider.data.length,
                (index) => Builder(
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(slider.data[index].gambar),
                                  fit: BoxFit.fill),
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(8.0)),
                        );
                      },
                    )),
            height: Curves.easeIn.transform(1) * 100,
            enlargeCenterPage: true,
            onPageChanged: (index) {
              setState(() {
                currentSlide = index;
              });
            },
          ),
          Positioned(
            // alignment: Alignment.bottomLeft,
            bottom: -5.0,
            right: 0.0,
            left: 0.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(slider.data.length, (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentSlide == index
                            ? Colors.red[400]
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                })),
          )
        ],
      ),
    );
  }

  _category(BuildContext context, ProductModeltwo result) {
    return Container(
        height: 160,
        child: Container(
            decoration: BoxDecoration(
              color: MyTools.primaryColor,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    result.data.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 350),
                                    pageBuilder: (context, _, __) => Kategori(
                                          user: this.widget.user,
                                          data: result.data[index],
                                        ))),
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.red[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // height: 50,
                              width: 100,
                              child: Center(
                                child: Container(
                                    height: 180,
                                    child: MyTools.imageProvider(
                                        result.data[index].gambar ??
                                            'http://siplah.mascitra.co.id/assets/images/no-image.png',
                                        context,
                                        height: 180)),
                              ),
                            ),
                          ),
                        )),
              ),
            )));
  }

  _listProductFromCategory(Datum category) {
    if (category.produk == null) {
      return Container();
    }
    return Container(
      height: 225,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3)
      ]),
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    image: DecorationImage(
                        image: NetworkImage(category.gambar != null
                            ? category.gambar
                            : 'http://siplah.mascitra.co.id/assets/images/no-image.png'))),
                child: SizedBox(
                  height: 220,
                  width: 150,
                  child: Container(
//            color: Colors.brown,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Container(
                height: 180,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 3)
                ]),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: category?.produk?.length,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
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
                                  pageBuilder: (context, _, __) =>
                                      ProductDetailPage(
                                          mitraId:
                                              category.produk[index].userId,
                                          categoryId: category.id,
                                          user: this.widget.user,
                                          productId:
                                              category.produk[index].id))),
                          child: Container(
                            width: 130,
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 8.0,
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Container(
                                    child: (category.produk[index].foto != null)
                                        ? MyTools.imageProvider(
                                            category.produk[index].foto[0].foto,
                                            context)
                                        : Image.network(
                                            'http://siplah.mascitra.co.id/assets/images/no-image.png',
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
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 40,
                                  width: 110,
                                  child: Text(
                                    category.produk[index].produk,
                                    style: MyTools.regular(
                                        size: 12, color: Colors.black87),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  child: Text(
                                    category.produk[index].harga != '0'
                                        ? "Rp " + category.produk[index].harga
                                        : "harga zona",
                                    style: MyTools.boldStyle(
                                        size: 14, color: Colors.redAccent),
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
              ),
            ],
          )
        ],
      ),
    );
  }

  _listProducts(context, RcData result ) {
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
                    result.namaProduk,
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
