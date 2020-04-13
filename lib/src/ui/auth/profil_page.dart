import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/profil/profil_bloc.dart';
import 'package:siplah_jpmall/src/bloc/profil/profil_state.dart';
import 'package:siplah_jpmall/src/models/mitra_user.dart';
import 'package:siplah_jpmall/src/models/sekolah_user.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class ProfilPage extends StatefulWidget{
  final UserData user;

  const ProfilPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> with ProfileState {
  final bloc = ProfilBloc();
  @override
  void initState() {
    super.initState();
    firstLoad(this.widget.user.id, this.widget.user.levelId);
  }

  @override
  ProfilPageState createState() => this;

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: this.widget.user.levelId == "3" ? _mitra(context) : _sekolah(context),
    );
  }

  _mitra(context) {
    return StreamBuilder<MitraUser>(
      stream: bloc.mitraUser,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data.error){
            return MyTools.errorWidget(context, message: "Sorry, Your Account is Not Found!");
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _profilePictureAndName(snapshot.data.data[0].foto, snapshot.data.data[0].nama, snapshot.data.data[0].email, snapshot.data.data[0].telepon)
              ],
            ),
          );
        }else if(snapshot.hasError){
          return MyTools.errorWidget(context, message: "Sorry, You Can't see Anything !");
        }return Center(child: CircularProgressIndicator(),);
      },
    );
  }
  _sekolah(context) {
    return StreamBuilder<SekolahUser>(
      stream: bloc.sekolahUser,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data.error){
            return MyTools.errorWidget(context, message: "Sorry, Your Account is Not Found!");
          }
        }else if(snapshot.hasError){
          return MyTools.errorWidget(context, message: "Sorry, You Can't see Anything !");
        }return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  _profilePictureAndName(String url, String name,String email,String phone) {
    return Container(
      height: MediaQuery.of(context).size.height * (1/4),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      shape: BoxShape.circle,
                      border: Border.all(width: 5, color: Colors.grey.withOpacity(0.8)),
                      image: DecorationImage(image:NetworkImage(url))
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Center(child: Icon(Icons.edit, color: Colors.white,size: 18,),),
                      decoration: BoxDecoration(
                          color: MyTools.darkAccentColor,
                          shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width/2,
                child: Center(child: Text(name, style: MyTools.boldStyle(color: MyTools.darkAccentColor, size: 20),))),
//            SizedBox(height: 4,),
            Text(email, style: MyTools.regular(color: MyTools.darkAccentColor.withOpacity(0.8), size: 13),)
          ],
        ),
      ),
    );
  }

}