import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';
import 'package:siplah_jpmall/src/ui/payment/payment_page.dart';
import 'package:siplah_jpmall/src/ui/sekolah/cart_page.dart';

import 'cart_bloc.dart';

abstract class CartState {
  CartPageState createState();
  CartPageState get _state => createState();

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

  update(String id, String idUser, {int qty = 1}) async {
    final _bool = await _bloc.update(id, qty: qty);
    if(_bool) {
      firstLoad(idUser);
    }else {
      showAlert(_state.context, "Gagal Mengupdate Jumlah Barang");
    }
  }

  createPayment(String idUser, List<String> ids, CartModel result) async {
    print(_state.widget.user.id);
    final _bool = await _bloc.createPayment(idUser, ids);
    if(!_bool['Error']) {
      print("Success, Create Payment");
      Navigator.push(_state.context, MaterialPageRoute(builder: (context) => PaymentPage(
        user: _state.widget.user,
        id: _bool['Data']['transaksi_id'].toString(),
        result: result,
      )));
    }else {
      showAlert(_state.context, "Gagal Membuat Pembayaran");
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