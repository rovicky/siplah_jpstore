import 'package:provider/provider.dart';
import 'package:siplah_jpmall/src/bloc/splash/splash_bloc.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:siplah_jpmall/src/ui/mainpage.dart';
import 'package:siplah_jpmall/src/ui/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class SplashState{
  SplashPageState createState();

  SplashPageState get _state => createState();

  SplashBloc get _bloc => _state.bloc;

  Future firstLoad() async {
    final UserData userData = await Provider.of<AuthProvider>(_state.context, listen: false).getUserInfo();
    if(await isFirstTime()){
      print(await isFirstTime());
      onLoading().then((value) => Navigator.pushReplacement(_state.context, MaterialPageRoute(builder: (context) => WelcomePage())));
    }else {
      onLoading().then((value) =>
          Navigator.pushReplacement(_state.context, MaterialPageRoute(
              builder: (context) => MainPage(user: userData,))));
    }
  }
  Future onLoading() => Future.delayed(Duration(milliseconds: 300));
  Future<bool> isFirstTime() => _bloc.getFirstTimeLaunched();
  Future setFirstTime() => _bloc.setFirstTimeLaunched();
}