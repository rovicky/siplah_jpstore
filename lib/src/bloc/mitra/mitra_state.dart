import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/mitra/marketing_page.dart';
import 'package:siplah_jpmall/src/ui/mitra/mitra_cabang.dart';
import 'package:siplah_jpmall/src/ui/mitra/mitra_order_page.dart';
import 'package:siplah_jpmall/src/ui/mitra/mitra_page.dart';
import 'package:siplah_jpmall/src/ui/mitra/mitra_produk.dart';

abstract class MitraState {
  MitraPageState createState();
  MitraPageState get _state => createState();

  MitraBloc get _bloc => _state.bloc;

  load(String mitraId) {
    _bloc.getItem(mitraId);
  }
}

class ListItem {
  final String title;
  final Function onPressed;

  ListItem({this.title, this.onPressed});
}
List<ListItem> list(context, UserData user) => [
  ListItem(title: "Produk", onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MitraProductPage(user: user,)));
  }),
  ListItem(title: "Cabang Mitra", onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MitraCabangPage(user: user,)));
  }),
  ListItem(title: "Penjualan", onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MitraOrderPage(user: user,)));
  }),
  ListItem(title: "Marketing", onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MarketingPage(user: user,)));
  }),
  ListItem(title: "Kurir", onPressed: (){}),
];
