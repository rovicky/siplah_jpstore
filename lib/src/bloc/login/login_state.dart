import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/login/login_bloc.dart';
import 'package:siplah_jpmall/src/models/result_user.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:siplah_jpmall/src/ui/mainpage.dart';
import 'package:siplah_jpmall/src/ui/splash_screen.dart';

abstract class LoginState {
  LoginPageState createdState();

  LoginPageState get _state => createdState();

  LoginBloc get _bloc => _state.bloc;

  submit() async {
//    debugPrint(_state.username.text);
    ResultUser resultUser =
        await _bloc.getLogin(_state.username.text, _state.password.text);
    if (!resultUser.error) {
      final result = await _bloc.setIdPreferences(resultUser.data.id);
      if(result){
        Navigator.pushReplacement(_state.context, MaterialPageRoute(builder: (context) => SplashPage()));
      }else{
        _showAlert("Tidak Bisa Login, Silahkan Login Kembali!");
      }
    } else if (resultUser.pesanUsr != null) {
      _showAlert(resultUser.pesanUsr);
    } else {
      _showAlert("Tidak Bisa Terhubung dengan Server!");
    }
  }

  void _showAlert(String text) {
    showDialog(
        context: _state.context,
        builder: (context) => AlertDialog(
              title: Text("Peringatan"),
              content: Text(text),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Tutup"),
                )
              ],
            ));
  }
}
