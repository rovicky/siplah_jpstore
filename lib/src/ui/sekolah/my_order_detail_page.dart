import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/my_order/my_order_detail_state.dart';
import 'package:siplah_jpmall/src/bloc/my_order/order_bloc.dart';
import 'package:siplah_jpmall/src/models/order_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class MyOrderDetailPage extends StatefulWidget {
  final String id;
  final UserData user;

  const MyOrderDetailPage({Key key, this.id, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyOrderDetailPageState();

}

class MyOrderDetailPageState extends State<MyOrderDetailPage> with MyOrderDetailState{

  final bloc = OrderBloc();

  @override
  void initState() {
    super.initState();
    setLoad(this.widget.user.id, this.widget.id);
  }

  @override
  MyOrderDetailPageState createState() => this;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Pesanan Anda", style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),),
      ),
      body: StreamBuilder<OrderModel>(builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data.error) {
            return MyTools.errorWidget(context, message: snapshot.data.pesanUsr);
          }else if(snapshot.data.data.length == 0 || snapshot.data.data == null) {
            return MyTools.errorWidget(context, message: "Pesanan Anda Tidak di Temukan!");
          }
          return SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              _customListTile(_address(context, snapshot.data.data[0].mitra[0]))
            ],),
          );
        }else if(snapshot.hasError) {
          return MyTools.errorWidget(context, message: snapshot.error.toString());
        }return Center(child: CircularProgressIndicator(),);
      }, stream: bloc.myOrder,),
    );
  }

  _customListTile(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 3),
      child: Container(
        width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
        child: child
      ),
    );
  }
  _address(context, Mitra result) {
    return Container(
      width: MediaQuery.of(context).size.width * (1/2) + 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Alamat Pengiriman", style: MyTools.boldStyle(
                size: 14,
                color: MyTools.darkAccentColor,
              )),
              IconButton(icon: Icon(Icons.arrow_forward_ios, size: 15,), onPressed: (){})
            ],
          ),
          Text("${result.alamatPengirimanNama} - ${result.alamatPengirimanAlamat}, ${result.alamatPengirimanKecamatanNama}, ${result.alamatPengirimanKabupatenNama}, ${result.alamatPengirimanProvinsiNama}",
            style: MyTools.regular(
              size: 11,
              color: MyTools.darkAccentColor
            ),
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis
          ),
          SizedBox(height: 5,),
        ],
      )
    );
  }

}