import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/settings/setting_bloc.dart';
import 'package:siplah_jpmall/src/ui/page_profile.dart';

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
}