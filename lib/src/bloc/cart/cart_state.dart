import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';

import 'cart_bloc.dart';

abstract class CartState {
  CartsPageState createState();
  CartsPageState get _state => createState();

  CartBloc get _bloc => _state.bloc;

  firstLoad(String id) async {
    _bloc.getData(id);
  }

  delete(String id, String idUser) async {
    final _bool = await _bloc.delete(id, idUser);
    if(_bool) {
      firstLoad(idUser);
      showAlert(_state.context, "Berhasil Menghapus Barang");
    }else {
      showAlert(_state.context, "Gagal Menghapus Barang");
    }
  }
  void showAlert(BuildContext context, String isi) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Peringatan"),
          content: Text(isi + " !."),
        ));
  }
  void showAlert1(BuildContext context, String idx, String idUser) {
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
                  delete(idx, idUser);
                }),
          ],
        ));
  }
}