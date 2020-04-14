import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/address/address_bloc.dart';
import 'package:siplah_jpmall/src/bloc/address/address_state.dart';
import 'package:siplah_jpmall/src/models/address_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class AddressListPage extends StatefulWidget {
  final UserData user;

  const AddressListPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AddressListPageState();
}

class AddressListPageState extends State<AddressListPage> with AddressState {
  final bloc = AddressBloc();

  @override
  AddressListPageState createState() => this;

  @override
  void initState() {
    super.initState();
    firstLoad(this.widget.user.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Alamat Pengiriman",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: StreamBuilder<AddressModel>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MyTools.errorWidget(context,
                message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            if (snapshot.data.error ?? snapshot.data.error != null) {
              return MyTools.errorWidget(context,
                  message: snapshot.data.message);
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(snapshot.data.data.length,
                    (index) => _customTile(context, snapshot.data.data[index])),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        stream: bloc.adressList,
      ),
    );
  }

  _customTile(context, Datum result) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7, left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  result.nama,
                  style: MyTools.boldStyle(
                      color: MyTools.darkAccentColor, size: 16),
                ),
                subtitle: Container(
                  width: MediaQuery.of(context).size.width * (1 / 2) + 20,
                  child: RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: result.penerimaNama,
                          style: MyTools.boldStyle(
                              color: MyTools.darkAccentColor.withOpacity(0.8),
                              size: 14)),
                      TextSpan(
                          text: "\n" + result.alamat,
                          style: MyTools.regular(
                              size: 12,
                              color: MyTools.darkAccentColor.withOpacity(0.8))),
                      TextSpan(
                          text: "\nTelepon : 0" + result.penerimaNoHp,
                          style: MyTools.regular(
                              size: 12,
                              color: MyTools.darkAccentColor.withOpacity(0.8)))
                    ],
                  )),
                ),
              ),
              Row(
                children: <Widget>[
                  result.isUtama == "1" ? MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "UTAMAKAN",
                      style: TextStyle(color: MyTools.primaryColor),
                    ),
                  ) : Container(),
                  Spacer(
                    flex: 1,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "UBAH",
                      style: TextStyle(color: MyTools.primaryColor),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "HAPUS",
                      style: TextStyle(color: MyTools.primaryColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
