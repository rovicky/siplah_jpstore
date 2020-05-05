import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/marketing_state.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/models/marketing_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class MarketingPage extends StatefulWidget {
  final UserData user;

  const MarketingPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MarketingPageState();
}

class MarketingPageState extends State<MarketingPage> with MarketingState {
  final bloc = MitraBloc();

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
          "Marketing",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: StreamBuilder<MarketingModel>(
          stream: bloc.marketing,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.data.length == 0) {
                return MyTools.errorWidget(context, message: "Tidak Ada Data");
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _widgetListTile(context,
                          key: "Tambah Marketing", onPressed: () {}),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            snapshot.data.data.length,
                            (index) => _widgetForMarketingUser(context,
                                id: snapshot.data.data[index].id,
                                location:
                                    snapshot.data.data[index].namaKabupaten,
                                name: snapshot.data.data[index].nama,
                                profileUrl: snapshot.data.data[index].foto)),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return MyTools.errorWidget(context, message: "snapshot error!");
            }
            return Center(
              child: MyTools.loadingWidget,
            );
          }),
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

  _widgetForMarketingUser(context,
      {String name,
      String location,
      String profileUrl,
      String id,
      Function onPressed}) {
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
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(profileUrl ?? BaseUrl.baseImage),
            ),
            onTap: onPressed ?? () {},
            title: Text(name ?? "Tidak Bernama",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: MyTools.boldStyle(
                    size: 13, color: MyTools.darkAccentColor)),
            subtitle: Row(
              children: <Widget>[
                Icon(
                  Icons.place,
                  color: MyTools.redColor,
                  size: 15,
                ),
                Text(
                  location ?? "-",
                  style:
                      MyTools.regular(size: 10, color: MyTools.darkAccentColor),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              onSelected: (value) {
                if(value == 1) {
                  //hapus marketing
                  delete(this.widget.user.id, id);
                }
              },
              itemBuilder: (context) => [
                {"title": "Hapus", "id": 1}
              ]
                  .map((x) => PopupMenuItem(
                      value: x['id'],
                      child: Text(
                        x['title'],
                        style: MyTools.regular(
                            size: 12, color: MyTools.darkAccentColor),
                      )))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  MarketingPageState createState() => this;
}
