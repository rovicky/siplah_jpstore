import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_cabang_state.dart';
import 'package:siplah_jpmall/src/models/mitra/cabang_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/mitra/add_cabang_page.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class MitraCabangPage extends StatefulWidget {
  final UserData user;

  const MitraCabangPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MitraCabangPageState();
}

class MitraCabangPageState extends State<MitraCabangPage>
    with MitraCabangState {
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
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Cabang Mitra",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child:
                  _widgetListTile(context, key: "Tambah Cabang", onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCabangPage(
                              user: this.widget.user,
                            )));
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                "Daftar Cabang",
                style:
                    MyTools.regular(size: 13, color: MyTools.darkAccentColor),
              ),
            ),
            StreamBuilder<CabangModel>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data.length == 0) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: MyTools.errorWidget(context,
                            message: "Tidak Ada Data"),
                      ),
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(snapshot.data.data.length, (index) {
                      var cabangData = snapshot.data.data[index];
                      return _widgetTile(context,
                          key: cabangData.nama,
                          subtitle: cabangData.namaKabupaten,
                          url: cabangData.foto,
                          id: cabangData.id,
                          result: snapshot.data.data[index]);
                    }),
                  );
                } else if (snapshot.hasError) {
                  return MyTools.errorWidget(context,
                      message:
                          "Snapshot Error!, please contact Admin or update your app");
                }
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: MyTools.loadingWidget,
                  ),
                );
              },
              stream: bloc.cabang,
            )
          ],
        ),
      ),
    );
  }

  _widgetListTile(context,
      {String key,
      Function onPressed,
      String url,
      String subtitle,
      String id}) {
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

  _widgetTile(context,
      {String key,
      Function onPressed,
      String url,
      String subtitle,
      String id,
      Cabang result}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7, left: 10, right: 10),
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
            trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    delete(id, this.widget.user.id);
                    print("Hapus");
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCabangPage(
                                  cabang: result,
                                  user: this.widget.user,
                                )));
                    print("Edit");
                  }
                },
                itemBuilder: (context) => <Map<String, dynamic>>[
                      {"title": "Hapus", "icon": Icons.delete_outline, "id": 1},
                      {"title": "Edit", "icon": Icons.edit, "id": 2},
                    ]
                        .map((x) => PopupMenuItem(
                            value: x['id'],
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  x['icon'],
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  x['title'],
                                  style: MyTools.regular(
                                      size: 12, color: MyTools.darkAccentColor),
                                ),
                              ],
                            )))
                        .toList()),
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: url == null
                          ? AssetImage(BaseUrl.placeholder)
                          : NetworkImage(url))),
            ),
            onTap: onPressed ?? () {},
            title: Text(key ?? "Tidak Ada Judul",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    MyTools.regular(size: 12, color: MyTools.darkAccentColor)),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.place,
                  color: MyTools.redColor,
                  size: 13,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(subtitle ?? "-",
                    style: MyTools.regular(
                        size: 10, color: MyTools.darkAccentColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  MitraCabangPageState createState() => this;
}
