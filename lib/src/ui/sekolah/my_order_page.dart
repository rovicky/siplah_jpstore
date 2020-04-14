import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/my_order/my_order_state.dart';
import 'package:siplah_jpmall/src/bloc/my_order/order_bloc.dart';
import 'package:siplah_jpmall/src/models/order_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class MyOrderPage extends StatefulWidget {
  final UserData user;

  const MyOrderPage({Key key, @required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyOrderPageState();
}

class MyOrderPageState extends State<MyOrderPage> with MyOrderState {
  final bloc = OrderBloc();

  @override
  void initState() {
    super.initState();
    setLoad(this.widget.user.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  MyOrderPageState createState() => this;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Pesanan",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: StreamBuilder<OrderModel>(
          stream: bloc.myOrderList,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return MyTools.errorWidget(context, message: snapshot.error.toString());
            }else if(snapshot.hasData) {
              if(snapshot.data.error){
                return MyTools.errorWidget(context, message: snapshot.data.pesanUsr);
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(snapshot.data.data.length, (index) => _customTile(context, snapshot.data.data[index])),
                ),
              );
            }return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }

  _customTile(context, Datum result) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4, top: 4),
      child: Container(
        padding: MyTools.defaultPadding(bottom: 8),
        width: double.infinity,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15,),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(result.mitra[0].foto ?? BaseUrl.baseImage))
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(child: Text(result.mitra[0].nama, style: MyTools.boldStyle(size: 14, color: MyTools.darkAccentColor),), width: MediaQuery.of(context).size.width * (1/2) + 30),
                      Container(child: Text(result.mitra[0].kabupatenNama, style: MyTools.regular(size: 13, color: MyTools.darkAccentColor),), width: MediaQuery.of(context).size.width * (1/2) + 30),
                    ],
                  )
                ],
              ),
            ),
            Column(mainAxisSize: MainAxisSize.min, children: List.generate(result.mitra[0].produk.length, (index) => Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: Colors.black54),
              ),
              child: Center(child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(result.mitra[0].produk[index].foto ?? BaseUrl.baseImage))
                  ),
                ),
                title: Text(result.mitra[0].produk[index].nama.length < 30 ? result.mitra[0].produk[index].nama : result.mitra[0].produk[index].nama.substring(0, 30) + "..."),
                subtitle: Text(result.mitra[0].produk[index].jumlah + "x | Rp " + MyTools.priceFormat(int.parse(result.mitra[0].produk[index].harga
                ))),
              ),),
            )),),
          ],
        ),
      ),
    );
  }
}
