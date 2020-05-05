import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/ui/mitra/mitra_cabang.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

abstract class MitraCabangState {
  MitraCabangPageState createState();

  MitraCabangPageState get _state => createState();

  MitraBloc get _bloc => _state.bloc;

  load(String mitraId) {
    _bloc.cabangLoad(mitraId);
    print("load");
  }

  delete(String id, String mitraId) async {
    final result = await _bloc.deleteCabang(id);
    if (!result['Error']) {
      dialog(_state.context, "Success", result['Pesan_usr'], () {
        Navigator.pop(_state.context);
        load(mitraId);
      });
    } else {
      dialog(_state.context, "Failed", result['Pesan_usr'], () {
        Navigator.pop(_state.context);
      });
    }
  }

  dialog(context, String title, String content, Function onPressed) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                title ?? "Why I cant see anything ?",
                style:
                    MyTools.regular(size: 13, color: MyTools.darkAccentColor),
              ),
              content: Text(content ?? "You can message me on Telegram"),
              actions: <Widget>[
                FlatButton(onPressed: onPressed, child: Text("Tutup"))
              ],
            ));
  }
}
