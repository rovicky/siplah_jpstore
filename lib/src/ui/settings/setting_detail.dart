import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:siplah_jpmall/src/bloc/settings/setting_bloc.dart';
import 'package:siplah_jpmall/src/bloc/settings/setting_detail_state.dart';
import 'package:siplah_jpmall/src/models/setting_detail_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class SettingDetailPage extends StatefulWidget {
  final String id;
  final UserData user;

  const SettingDetailPage({Key key, this.id, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SettingDetailPageState();
}

class SettingDetailPageState extends State<SettingDetailPage> with SettingDetailState {
  final bloc = SettingBloc();

  @override
  SettingDetailPageState createState() => this;

  @override
  void initState() {
    super.initState();
    load(this.widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingDetail>(
        stream: bloc.settingDetail,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Scaffold(body: MyTools.errorWidget(context, message: snapshot.error.toString()));
          }else if(snapshot.hasData) {
            if(snapshot.data.error) {
              return Scaffold(body: MyTools.errorWidget(context, message: snapshot.data.pesanUsr));
            }
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(snapshot.data.data[0].judul, style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),),
              ),
                body: SingleChildScrollView(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    HtmlWidget(snapshot.data.data[0].content, textStyle: MyTools.regular(size: 16, color: MyTools.darkAccentColor), webView: true,),
                  ],
                )));
          }return Scaffold(body: Center(child: CircularProgressIndicator(),));
        }
      );
  }
}