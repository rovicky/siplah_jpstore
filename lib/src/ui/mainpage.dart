import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';
import 'package:siplah_jpmall/src/ui/page_feeds.dart';
import 'package:siplah_jpmall/src/ui/page_home.dart';
import 'package:siplah_jpmall/src/ui/page_officialstore.dart';
import 'package:siplah_jpmall/src/ui/page_profile.dart';

class MainPage extends StatefulWidget {
  final UserData user;

  const MainPage({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double posisi = 0.0;
  int currentPage = 0;
  ScrollController _controller;
  _scrollListener() {
    setState(() {
      posisi = _controller.offset;
    });
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF6BB8E3), //top bar color
      statusBarIconBrightness: Brightness.light, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  List<Widget> _page(UserData user) => [
        HomePage(
          user: user,
        ),
        CartsPage(
          user: user,
        ),
        FeedsPage(
          user: user,
        ),
        ProfilePage(
          user: user,
        )
      ];

  void _tabItem(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(this.widget.user)[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: _tabItem,
        fixedColor: Colors.purple,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              // backgroundColor:
              title: Text(
                "home",
                style: TextStyle(fontSize: 12),
              ),
              icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text(
                "Carts",
                style: TextStyle(fontSize: 12),
              ),
              icon: Icon(
                Icons.shopping_cart,
              )),
          BottomNavigationBarItem(
              title: Text(
                "Mitra",
                style: TextStyle(fontSize: 12),
              ),
              icon: Icon(
                Icons.group,
              )),
          BottomNavigationBarItem(
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 12),
              ),
              icon: Icon(
                Icons.account_circle,
              )),
        ],
      ),
    );
  }
}
