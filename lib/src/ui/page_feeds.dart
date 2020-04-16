import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/models/mitra_list_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/mitra/detail_mitra.dart';
import 'package:siplah_jpmall/src/ui/myappbar.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';
import '../../src/bloc/mitra/feed_state.dart';

class FeedsPage extends StatefulWidget {
  final UserData user;

  const FeedsPage({Key key, this.user,}) : super(key: key);
  @override
  FeedsPageState createState() => FeedsPageState();
}

class FeedsPageState extends State<FeedsPage> with FeedState {

  final bloc = MitraBloc();
  
  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 66),
        child: SafeArea(child: Container(child: MyAppBarAbNormal(), decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 3,
                color: Colors.black12,
                offset: Offset(0, 3))
          ],
          color: MyTools.primaryColor,
        ),)),
      ),
      body: StreamBuilder<MitraListModel>(
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data.error){
              return MyTools.errorWidget(context,message: snapshot.data.message);
            }else if(snapshot.data.data.length == 0) {
              return MyTools.errorWidget(context,message: "Belum ada Mitra Yang ditambahkan");
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(snapshot.data.data.length, (index) => _customListTile(snapshot.data.data[index])),
              ),
            );
          }else if(snapshot.hasError) {
            return MyTools.errorWidget(context, message: snapshot.error.toString());
          }return Center(child: CircularProgressIndicator(),);
        },
        stream: bloc.mitraList,
      )
    );
  }

  _customListTile(Datum result) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 3),
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
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMitraPage(user: this.widget.user, mitraId: result.id,))),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(result.foto ?? BaseUrl.baseImage)
                )
              ),
            ),
              title: Text(result.nama, style: MyTools.boldStyle(size: 16, color: MyTools.darkAccentColor),),
              subtitle: Text(result.provinsiNama ?? '-', style: MyTools.regular(size: 14,color: MyTools.darkAccentColor.withOpacity(0.8)),),
          ),
        ),
      ),
    );
  }

  @override
  FeedsPageState createState() => this;

}