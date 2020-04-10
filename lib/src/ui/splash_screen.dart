import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/splash/splash_bloc.dart';
import 'package:siplah_jpmall/src/bloc/splash/splash_state.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:siplah_jpmall/src/ui/mainpage.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with SplashState{
  final bloc = SplashBloc();

  @override
  void initState() {
    super.initState();
    firstLoad().then((value) async {
      setFirstTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(flex: 1,),
            Container(
              height: 150,
                child: Image.asset("src/image/ic_launcher.png", fit: BoxFit.cover,)),
            Spacer(flex: 1,),
            CircularProgressIndicator(),
            SizedBox(height: MediaQuery.of(context).size.height * (1 / 8),)
          ],
        ),
      ),
    );
  }

  @override
  SplashPageState createState() => this;
}
