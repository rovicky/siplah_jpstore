import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/bloc/cart/cart_bloc.dart';
import 'package:siplah_jpmall/src/bloc/cart/cart_state.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/auth/login_page.dart';
import 'package:siplah_jpmall/src/ui/pembayaran.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/ui/sekolah/cart_page.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class CartsPage extends StatefulWidget {
  final UserData user;

  const CartsPage({Key key, this.user}) : super(key: key);
  @override
  CartsPageState createState() => CartsPageState();
}

class CartsPageState extends State<CartsPage> {

  @override
  Widget build(BuildContext context) {
    if (this.widget.user == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyTools.errorWidget(context,
                  message: "Upss!. Kamu Belum Login, Login Dulu Yuk ! "),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage())),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 40,
                minWidth: 120,
                color: Colors.redAccent,
                child: Text("Login Disini",
                  style: MyTools.boldStyle(color: Colors.white, size: 15),),
              )
            ],
          ),
        ),
      );
    }

    return CartPage(user: this.widget.user,);
  }
}