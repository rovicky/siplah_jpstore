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
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[],),
          );
        }else if(snapshot.hasError) {
          return MyTools.errorWidget(context, message: snapshot.error.toString());
        }return Center(child: CircularProgressIndicator(),);
      }, stream: bloc.myOrder,),
    );
  }


}