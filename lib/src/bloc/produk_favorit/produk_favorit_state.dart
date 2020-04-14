import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_bloc.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';

import '../../ui/produk_favorit.dart';

abstract class ProductFavState {
  ProdukFavoritState createState();

  ProdukFavoritState get _state => createState();

  ProdukFavBloc get _bloc => _state.bloc;

  firstLoad(String idUser) async {
    _bloc.getData(idUser);
  }

  deleteData(String id, String idUser) async {
//    String idUser = await Provider.of<AuthProvider>(_state.context, listen: false).getCredential();
    _bloc.deleteData(id, idUser).then((value) {
      if(value) {
        firstLoad(idUser);
        _berhasil(_state.context);
      }else {
        _showAlert(_state.context);
      }
    });
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
          content: Text("Buku telah dihapus dari daftar favorit"),
        ));
  }
}