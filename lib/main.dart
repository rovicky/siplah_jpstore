import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siplah_jpmall/src/ui/splash_screen.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: MyTools.primaryColor, //top bar color
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
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