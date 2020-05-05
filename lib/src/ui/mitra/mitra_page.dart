import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_state.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class MitraPage extends StatefulWidget {
  final UserData user;

  const MitraPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MitraPageState();
}

class MitraPageState extends State<MitraPage> with MitraState {
  final bloc = MitraBloc();
  var item = [
    {"icon": Icons.shopping_cart, "key": "pesanan", "value": 58},
    {"icon": Icons.shopping_basket, "key": "produk", "value": 58},
    {"icon": Icons.message, "key": "komplain", "value": 0},
    {"icon": Icons.compare_arrows, "key": "negosiasi", "value": 0},
  ];

  @override
  void initState() {
    super.initState();
    load(this.widget.user.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Dashboard",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: MyTools.darkAccentColor,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              StreamBuilder<List<String>>(
                  stream: bloc.item,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                            snapshot.data.length,
                            (index) => _widgetHighlight(context,
                                icon: item[index]['icon'],
                                key: item[index]['key'],
                                value: snapshot.data[index])),
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    }
                    return Container(
                      height: 150,
                      child: Center(
                        child: MyTools.loadingWidget,
                      ),
                    );
                  }),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      list(context, this.widget.user).length,
                      (index) => _widgetListTile(context,
                          key: list(context, this.widget.user)[index].title,
                          onPressed: list(context, this.widget.user)[index].onPressed)))
            ],
          ),
        ),
      ),
    );
  }

  _widgetHighlight(context, {String key, String value, IconData icon}) {
    return Card(
      child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width / 2 - 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon ?? Icons.dashboard,
                size: 25,
                color: MyTools.darkAccentColor,
              ),
              SizedBox(width: 15),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    value ?? "0",
                    style: MyTools.regular(
                        size: 16, color: MyTools.darkAccentColor),
                  ),
                  Text(
                    key ?? "Belum Ada Data",
                    style: MyTools.regular(
                        size: 10, color: MyTools.darkAccentColor),
                  )
                ],
              )
            ],
          )),
    );
  }

  _widgetListTile(context, {String key, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: onPressed ?? () {},
            title: Text(key ?? "Tidak Ada Judul",
                style: MyTools.boldStyle(
                    size: 14, color: MyTools.darkAccentColor)),
          ),
        ),
      ),
    );
  }

  @override
  MitraPageState createState() => this;
}
