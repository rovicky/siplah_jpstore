import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/gridproduk.dart';
import 'package:siplah_jpmall/src/ui/myappbar.dart';
import 'package:siplah_jpmall/src/ui/myflexspace.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';

class Kategori extends StatefulWidget {
  final Datum data;
  final UserData user;

  const Kategori({Key key, this.data, @required this.user}) : super(key: key);
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
   List data;
  List data2;
  List kategorilist;
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
                  decoration: BoxDecoration(
          color: Colors.blueAccent),
                  child: FlexibleSpaceBar(
                    background: MyFlexSpace(),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
               GridProduk(result: widget.data, user: this.widget.user,)
              ]),
            ],
          )),
    );
  }
}
