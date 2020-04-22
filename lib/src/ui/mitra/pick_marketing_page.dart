import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/bloc/mitra/pick_mrktng_state.dart';
import 'package:siplah_jpmall/src/models/marketing_model.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class PickMarketingPage extends StatefulWidget {
  final String mitraId;

  const PickMarketingPage({Key key, this.mitraId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PickMarketingPageState();

}

class PickMarketingPageState extends State<PickMarketingPage> with PickMarketingState{
  final bloc = MitraBloc();

  @override
  void initState() {
    super.initState();
    load(this.widget.mitraId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          "Pilih Marketing",
          style: MyTools.boldStyle(color: MyTools.darkAccentColor, size: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<MarketingModel>(
          stream: bloc.marketing,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              if(snapshot.data.error) {
                return MyTools.errorWidget(context, message: snapshot.data.message);
              }else if(snapshot.data.data.length == 0) {
                return MyTools.errorWidget(context,message: "Belum Ada Marketing untuk toko ini");
              }
              /**
               * id": "18",
                  "kode": "011500023",
                  "kategori": "1",
                  "foto": "https://siplah.jpstore.id/api/cdn/35/foto/0F1323D2-EF4B-D0A3-61A8-4F5FB7EE02C3.jpeg",
                  "nama": "Dilang Eka Prasetiariga",
               */
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(snapshot.data.data.length, (index) => _customListTile({
                    "title":snapshot.data.data[index].kode,
                    "subtitle":snapshot.data.data[index].nama,
                    "onPressed":(){
                      Navigator.pop(context, {
                        "id":snapshot.data.data[index].id,
                        "code":snapshot.data.data[index].kode,
                        "name":snapshot.data.data[index].nama
                      });
                    }
                  })),
                ),
              );
            }else if (snapshot.hasError) {
              return MyTools.errorWidget(context, message: snapshot.error.toString());
            } return Center(child: MyTools.loadingWidget,);
          },
      ),
    );
  }

  _customListTile(Map<String, dynamic> child) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7, right: 10, left: 10),
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
            onTap: () {
              child['onPressed']();
            },
            title: Text(
              child['title'],
              style:
              MyTools.boldStyle(color: MyTools.darkAccentColor, size: 14),
            ),
            subtitle: child['subtitle'] == null
                ? null
                : Text(
              child['subtitle'] ?? '',
              style: MyTools.regular(
                  size: 12, color: MyTools.darkAccentColor),
            ),
          ),
        ),
      ),
    );
  }

  @override
  PickMarketingPageState createState() => this;
}