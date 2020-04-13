import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/home/home_bloc.dart';
import 'package:siplah_jpmall/src/bloc/home/home_state.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/gridkategori.dart';
import 'package:siplah_jpmall/src/ui/imageslider.dart';
import 'package:siplah_jpmall/src/ui/myappbar.dart';
import 'package:siplah_jpmall/src/ui/myflexspace.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
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
  @override
  HomePageState createState() => this;

  double posisi = 0.0;
  int currentPage = 0;
  ScrollController _controller;

  _scrollListener() {
    setState(() {
      posisi = _controller.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    firstLoad((this.widget.user != null) ? this.widget.user.id : '');
//    print(this.widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: FlexibleSpaceBar(
                    background: MyFlexSpace(),
                  ),
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () => firstLoad(this.widget.user == null ? '' : this.widget.user.id),
            child: StreamBuilder<ProductModeltwo>(
                stream: bloc.homeContent,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Can't Load this content"),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data.error) {
                      return Center(
                        child: Text("No Content"),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            ImageSlider(),
                            SizedBox(
                              height: 10,
                            ),
                            //FlashDeal(data: _listProduk),
                            SizedBox(
                              height: 10,
                            ),
                            _category(context, snapshot.data),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey[400])),
                            ),

                            Container(
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                        snapshot.data.data.length,
                                        (index) => Container(
                                                child: Column(
                                              children: <Widget>[
                                                _listProductFromCategory(snapshot.data.data[index]),
//                                                Nontext(
//                                                  level: this.widget.user.levelId,
//                                                  id: this.widget.user.id,
//                                                  data: snapshot
//                                                      .data.data[index].produk,
//                                                  kategori: snapshot
//                                                      .data.data[index].gambar,
//                                                ),
//                                    : CircularProgressIndicator(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                //Pendamping(data: data2,kategori: kategorilist,),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ))),
                                  ),
                                )),

                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ]),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )),
    );
  }

  _category(BuildContext context, ProductModeltwo result) {

    return Container(
        height: 160,
        child: Container(
          decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 5), blurRadius: 3),
          ]),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(result.data.length, (index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 350),
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
                        child: MyTools.imageProvider(result.data[index].gambar ?? 'http://siplah.mascitra.co.id/assets/images/no-image.png', context, height: 180)
                      ),
                    ),
                  ),
                ),
              )),
            ),
          )
        ));

  }

  _listProductFromCategory(Datum category) {
    if(category.produk == null) {
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
              ),Container(
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
                                  pageBuilder: (context, _, __) => ProductDetailPage(
                                    mitraId: category.produk[index].userId,
                                    categoryId: category.id,
                                    user: this.widget.user,
                                    productId: category.produk[index].id))),
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
