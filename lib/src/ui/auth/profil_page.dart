import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/profil/profil_bloc.dart';
import 'package:siplah_jpmall/src/bloc/profil/profil_state.dart';
import 'package:siplah_jpmall/src/models/mitra_user.dart';
import 'package:siplah_jpmall/src/models/sekolah_user.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/auth/address_list_page.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class ProfilPage extends StatefulWidget{
  final UserData user;

  const ProfilPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> with ProfileState {
  final bloc = ProfilBloc();
  ///umum
  TextEditingController name = TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController postalCode = new TextEditingController();
  TextEditingController latitude = new TextEditingController();
  TextEditingController longitude = new TextEditingController();


  ///sekolah
  TextEditingController sKepSekName = new TextEditingController();
  TextEditingController snpsn = new TextEditingController();
  TextEditingController snipKepSek = new TextEditingController();
  TextEditingController snipBendahara = new TextEditingController();
  TextEditingController sBendaharaName = new TextEditingController();

  ///mitra
  TextEditingController mRekName = new TextEditingController();
  TextEditingController mRekNo = new TextEditingController();
  TextEditingController mBankName = new TextEditingController();
  TextEditingController mNpwp = new TextEditingController();
  TextEditingController mFingerprint = new TextEditingController();
  TextEditingController mFingerprintPosition = new TextEditingController();


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
                _profilePictureAndName(snapshot.data.data[0].foto, snapshot.data.data[0].nama, snapshot.data.data[0].email, snapshot.data.data[0].telepon),
                _customListTile("Name", name = TextEditingController(text: snapshot.data.data[0].nama), isEditable: true),
                _customListTile("Deskipsi", description = TextEditingController(text: snapshot.data.data[0].deskripsi), isExpanded: true),
                _customListTile("Telepon", phone = TextEditingController(text: "+62"+snapshot.data.data[0].telepon)),
                _customListTile("NPWP", mNpwp = TextEditingController(text: snapshot.data.data[0].npwp)),
                _customListTile("Email", email = TextEditingController(text: snapshot.data.data[0].email)),
                _customListTile("Penanda Tangan", mFingerprint = TextEditingController(text: snapshot.data.data[0].penandaTangan)),
                _customListTile("Penanda Tangan Posisi", mFingerprintPosition = TextEditingController(text: snapshot.data.data[0].penandaTanganPosisi)),
                _customListTile("Alamat", alamat = TextEditingController(text: snapshot.data.data[0].alamat), isExpanded: true),
                MaterialButton(onPressed: () {}, child: Text("Edit"),)

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
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _profilePictureAndName(snapshot.data.data[0].foto ?? "https://siplah.jpstore.id/assets/images/logo_sekolah_default.png", snapshot.data.data[0].nama, snapshot.data.data[0].email, snapshot.data.data[0].telepon),
                _customListTile("Nama", name = TextEditingController(text: snapshot.data.data[0].nama), isEditable: true),
                _customListTile("Nomor Telepone", phone = TextEditingController(text: snapshot.data.data[0].telepon), isEditable: true),
                _customListTile("NPSN", snpsn = TextEditingController(text: snapshot.data.data[0].npsn), isEditable: true),
                _customListTile("Nama Kepala Sekolah", sKepSekName = TextEditingController(text: snapshot.data.data[0].sekolahKepala), isEditable: true),
                _customListTile("NIP Kepala Sekolah", snipKepSek = TextEditingController(text: "1234451234"), isEditable: true),
                _customListTile("Nama Bendahara", sKepSekName = TextEditingController(text: snapshot.data.data[0].sekolahKepala), isEditable: true),
                _customListTile("NIP Bendahara", snipBendahara = TextEditingController(text: "13244223"), isEditable: true),
                _customTile("Alamat Pengiriman", onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListPage(user: this.widget.user,)))),
                MaterialButton(onPressed: () {}, child: Text("Edit"),)
              ],
            )
          );
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
                child: Center(child: Text(name, style: MyTools.boldStyle(color: MyTools.darkAccentColor, size: 20), textAlign: TextAlign.center,))),
//            SizedBox(height: 4,),
            Text(email, style: MyTools.regular(color: MyTools.darkAccentColor.withOpacity(0.8), size: 13),)
          ],
        ),
      ),
    );
  }

  _customListTile(String title, TextEditingController textController, {bool enable = false, bool isEditable = true, bool isExpanded = false}) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: MyTools.boldStyle(size: 14, color: MyTools.darkAccentColor),
            ),
          ],
        ),
      ),
      subtitle: Container(
        height: isExpanded ? null : 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color:
                Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            title: TextField(
              enabled: enable,
              controller: textController,
              maxLines: isExpanded ? 5 : 1,
              style: MyTools.regular(color: MyTools.darkAccentColor, size: 16),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _customDropdown(String title, TextEditingController textController, {bool enable = false, bool isEditable = true, bool isExpanded = false}) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: MyTools.boldStyle(size: 14, color: MyTools.darkAccentColor),
            ),
          ],
        ),
      ),
      subtitle: Container(
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            title: DropdownButton(items: null, onChanged: null)
          ),
        ),
      ),
    );
  }

  _customTile(String title,{Function onPressed}) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
        child: Text(
          title,
          style: MyTools.boldStyle(size: 14, color: MyTools.darkAccentColor),
        ),
      ),
      subtitle: Padding(
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: ListTile(
              onTap: onPressed,
              title: Text(
                title,
                style: MyTools.boldStyle(color: MyTools.darkAccentColor, size: 16),
              ),
            ),
          ),
        ),
      )
    );
  }
}