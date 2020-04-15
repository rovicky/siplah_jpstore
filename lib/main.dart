import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:siplah_jpmall/src/ui/mainpage.dart';
import 'package:siplah_jpmall/src/ui/splash_screen.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF6BB8E3), //top bar color
        statusBarIconBrightness: Brightness.light, //top bar icons
        systemNavigationBarColor: Colors.white, //bottom bar color
        systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
      )
  );
  return runApp(MyApp());//test
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          canvasColor: Colors.transparent,
          primaryColor: Color(0xFF6BB8E3),
          accentColor: Color(0xFF3FCB9B),
    ),
    home: SplashPage()
    );
  }
}