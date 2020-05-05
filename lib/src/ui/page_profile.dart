import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/settings/setting_bloc.dart';
import 'package:siplah_jpmall/src/bloc/settings/setting_state.dart';
import 'package:siplah_jpmall/src/models/setting_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/settings/setting_detail.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';
class ProfilePage extends StatefulWidget {
  final UserData user;

  const ProfilePage({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> with SettingState {
  final bloc = SettingBloc();
  double position = 0;
  @override
  void initState() {
    super.initState();
    firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: _appBar(context),
      body: StreamBuilder<ResultSetting>(
          stream: bloc.setting,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Can't Load Data"),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data.error) {
                showAlert(snapshot.data.pesanUsr);
              }
              return SafeArea(child: _body(context, snapshot.data));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  _body(BuildContext context, ResultSetting snapshot) {
    final result = snapshot.data;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          (this.widget.user == null) ? Container() : _customListTile(
              "Profil",
              List.generate(
                  settingsDefault(context, this.widget.user).length,
                  (index) => {
                        "title": settingsDefault(context, this.widget.user)[index].title,
                        "subtitle": settingsDefault(context, this.widget.user)[index].subtitle,
                        "onPressed": settingsDefault(context, this.widget.user)[index].onPressed,

                      })),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                result.length,
                (index) => _customListTile(
                    result[index].nama,
                    List.generate(
                        result[index].page.length,
                        (i) => {
                              "title": result[index].page[i].judul,
                              "id": result[index].page[i].id,
                              "onPressed": (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingDetailPage(user: this.widget.user, id: result[index].page[i].id,)));
                              },
                              "subtitle": null,
                            }))),
          ),
          (this.widget.user == null) ? Container() : _customListTile(
              "Lain lain",
              List.generate(
                  settingMore(context).length,
                      (index) => {
                    "title": settingMore(context)[index].title,
                    "subtitle": settingMore(context)[index].subtitle,
                        "onPressed": settingMore(context)[index].onPressed
                  })),
        ],
      ),
    );
  }

  _customListTile(String title, List<Map<String, dynamic>> children) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
        child: Text(
          title,
          style: MyTools.boldStyle(size: 14, color: MyTools.darkAccentColor),
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            children.length,
            (i) => Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 7),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color:
                            Colors.black54.withOpacity(0.8).withAlpha(25),
                            blurRadius: 7,
                            offset: Offset(0, 0),
                            spreadRadius: 0.4)
                      ],
                      color: children[i]['title'] == "Keluar" ? Colors.redAccent :Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: ListTile(
                        onTap: () {
                          children[i]['onPressed']();
                        },
                        title: Text(
                          children[i]['title'],
                          style: MyTools.boldStyle(color: children[i]['title'] == "Keluar" ? Colors.white : MyTools.darkAccentColor, size: 16),
                        ),
                        subtitle: children[i]['subtitle'] == null ? null : Text(children[i]['subtitle'] ?? '', style: MyTools.regular(size: 13, color: MyTools.darkAccentColor),),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  ProfilePageState createState() => this;
}
