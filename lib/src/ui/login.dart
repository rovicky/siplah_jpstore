import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/kabupaten_bloc.dart';
import 'package:siplah_jpmall/src/bloc/kecamatan_bloc.dart';
import 'package:siplah_jpmall/src/bloc/login/login_bloc.dart';
import 'package:siplah_jpmall/src/bloc/login/login_state.dart';
import 'package:siplah_jpmall/src/bloc/provinsi_bloc.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/kabupaten_model.dart';
import 'package:siplah_jpmall/src/models/kecamatan_model.dart';
import 'package:siplah_jpmall/src/models/product_model.dart';
import 'package:siplah_jpmall/src/models/provinsi_model.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/auth/login_page.dart';
import 'dart:async';
import 'package:siplah_jpmall/src/ui/mainpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/ui/page_home.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

SharedPreferences sharedPreferences;

class _WelcomePageState extends State<WelcomePage> {
  var token;
  PageController _pageController;
  bool lastPage = false;
  int initialPage = 0;
  String usernama = null;

  String foto, npsn, nama, email, alamat, kodepos, telepon;

  final page = <ListPage>[
    ListPage(0, PagePertama()),
    ListPage(1, PageKedua()),
    ListPage(2, PageKetiga()),
  ];

  Future<http.Response> postRequest() async {
    var url = 'http://siplah.mascitra.co.id/api/api/get_token';

    Map data = {'app': 'siplah_jpmall.id'};
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    // print("${response.statusCode}");

    // print("${response.body}");
    Map<String, dynamic> map = jsonDecode(response.body);
    token = map["Data"][0]["api_token"];

    return response;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
//    postRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: initialPage == page.length - 1
          ? Container(
              height: 0.0,
            )
          : Container(
              height: 58,
              child: Stack(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Color(0xFF6BB8E3),
                    actions: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease);
                        },
                        child: lastPage == true
                            ? Text("Register",
                                style: TextStyle(color: Colors.white))
                            : Text("Next",
                                style: TextStyle(color: Colors.white)),
                      )
                    ],
                    title: lastPage == true
                        ? Container()
                        : MaterialButton(
                            child: Text(
                              "Skip",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _pageController.jumpToPage(2);
                            },
                          ),
                  ),
                  _dot(context)
                ],
              ),
            ),
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (i) {
            setState(() {
              initialPage = i;
            });
          },
          pageSnapping: true,
          children: page.map((ListPage page) {
            return page.widget;
          }).toList()),
    );
  }

  _dot(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: page.map((ListPage page) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: page.index == initialPage ? Colors.red : Colors.grey,
                  shape: BoxShape.circle),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ListPage {
  final int index;
  final Widget widget;

  ListPage(this.index, this.widget);
}

class PagePertama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF6BB8E3),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "ALAT",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Tulis, Peraga &\nPraktik",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Container(
                    width: 230,
                    child: Text(
                      "Lengkap dan Dengan Kualitas Yang Baik",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 3,
              right: 10,
              child: Container(
                child: Image.asset(
                  'src/image/buku.png',
                  scale: 6,
                ),
              ),
            )
          ],
        ));
  }
}

class PageKedua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF6BB8E3),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'src/image/buku_2.png',
                          scale: 5,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "BUKU",
                        style: TextStyle(
                            fontSize: 54,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Adalah\n            Jembatan",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "ILMU",
                        style: TextStyle(
                            fontSize: 54,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}

class PageKetiga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6BB8E3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage('src/image/project.png')),
          MaterialButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage())),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Start Now"),
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)))
        ],
      ),
    );
  }
}


