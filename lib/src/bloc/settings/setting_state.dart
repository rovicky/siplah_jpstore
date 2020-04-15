import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/settings/setting_bloc.dart';
import 'package:siplah_jpmall/src/models/setting_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/auth/profil_page.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:siplah_jpmall/src/ui/page_profile.dart';
import 'package:siplah_jpmall/src/ui/produk_favorit.dart';
import 'package:siplah_jpmall/src/ui/sekolah/my_order_page.dart';

abstract class SettingState {
  ProfilePageState createState();

  ProfilePageState get _state => createState();

  SettingBloc get _bloc => _state.bloc;

  firstLoad() async {
    _bloc.getData();
  }
  void showAlert(String msg) {
    showDialog(
        context: _state.context,
        builder: (context) => AlertDialog(
          title: Text("Peringatan"),
          content: Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tutup"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  List<SettingsDefault> settingsDefault(context, UserData user) {
    if(user.levelId == "3") {
      return [
        SettingsDefault(title: "Akun", subtitle: "Data diri, Alamat Pengiriman, dsb.", onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilPage(user: user,)));
        }),
      ];
    }else{
      return [
        SettingsDefault(title: "Akun", subtitle: "Data diri, Alamat Pengiriman, dsb.", onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilPage(user: user,)));
        }),
        SettingsDefault(title: "Pesanan",subtitle: null, onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderPage(user: user,)));
        }),
        SettingsDefault(title: "Produk Favorit",subtitle: null, onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukFavorit(user: user,)));
        }),
      ];
    }
  }
  List<SettingsDefault> settingMore(context) => [
    SettingsDefault(title: "Komplain", onPressed: (){}),
    SettingsDefault(title: "Keluar", onPressed: (){
      showDialog(
          context: _state.context,
          builder: (context) => AlertDialog(
            title: Text("Apakah Anda Yakin?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Tutup"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Ya"),
                onPressed: () async {
                  bool logOut = await AuthProvider().signOut();
                  if(logOut){
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
              ),
            ],
          ));
    }),
  ];
}