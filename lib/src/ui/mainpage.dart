import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/login.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';
import 'package:siplah_jpmall/src/ui/page_feeds.dart';
import 'package:siplah_jpmall/src/ui/page_home.dart';
import 'package:siplah_jpmall/src/ui/page_officialstore.dart';
import 'package:siplah_jpmall/src/ui/page_profile.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

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

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _page(UserData user) => [
        HomePage(
          user: user,
        ),
        CartsPage(
          user: user,
        ),
        user == null ? FeedsPage() :FeedsPage(
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
        elevation: 10.0,
        backgroundColor: Colors.white,
        fixedColor: MyTools.primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: _tabList(this.widget.user),
      ),
    );
  }

  List<BottomNavigationBarItem> _tabList(UserData user) => [
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
          (user == null || user.levelId == "2") ? Icons.group : Icons.dashboard,
        )),
    BottomNavigationBarItem(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 12),
        ),
        icon: Icon(
          Icons.account_circle,
        )),
  ];

}
