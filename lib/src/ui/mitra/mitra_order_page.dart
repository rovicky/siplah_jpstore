import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_order_state.dart';
import 'package:siplah_jpmall/src/models/mitra/order_in_mitra_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class MitraOrderPage extends StatefulWidget {
  final UserData user;

  const MitraOrderPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MitraOrderPageState();
}

class MitraOrderPageState extends State<MitraOrderPage> with MitraOrderState {
  final bloc = MitraBloc();

  @override
  void initState() {
    super.initState();
    load(this.widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pesanan",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: StreamBuilder<OrderInMitra>(
          stream: bloc.orderList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.data.length == 0) {
                return Center(
                  child:
                      MyTools.errorWidget(context, message: "Data Tidak Ada"),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          List.generate(snapshot.data.data.length, (index) {
                        return _customTile(context, snapshot.data.data[index]);
                      }),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: MyTools.errorWidget(context, message: "snapshot Error"),
              );
            }
            return Center(
              child: MyTools.loadingWidget,
            );
          }),
    );
  }

  _customTile(context, Datum result) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4, top: 4),
      child: GestureDetector(
        onTap: () {},
        child: Container(
            padding: MyTools.defaultPadding(bottom: 8),
            width: double.infinity,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    result.userFoto ?? BaseUrl.baseImage))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              child: Text(
                                result.userNama,
                                style: MyTools.boldStyle(
                                    size: 14, color: MyTools.darkAccentColor),
                              ),
                              width:
                                  MediaQuery.of(context).size.width * (1 / 2) +
                                      30),
                          Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    color: MyTools.redColor,
                                    size: 15,
                                  ),
                                  Text(
                                    result.dataAlamatPengirimanKabupatenNama,
                                    style: MyTools.regular(
                                        size: 13,
                                        color: MyTools.darkAccentColor),
                                  ),
                                ],
                              ),
                              width:
                                  MediaQuery.of(context).size.width * (1 / 2) +
                                      30),
                        ],
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      PopupMenuButton(
                          onSelected: (value) {
                            if (value == 1) {
                              _openPopupAcceptOrder(
                                  context, this.widget.user.id, result.id);
                              print("terima pesanan");
                            } else {
                              print("tolak pesanan");
                            }
                          },
                          itemBuilder: (context) => <Map<String, dynamic>>[
                                {
                                  "title": "Terima",
                                  "icon": Icons.check,
                                  "id": 1
                                },
                                {
                                  "title": "Tolak",
                                  "icon": Icons.close,
                                  "id": 2
                                },
                              ]
                                  .map((x) => PopupMenuItem(
                                      value: x['id'],
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            x['icon'],
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            x['title'],
                                            style: MyTools.regular(
                                                size: 12,
                                                color: MyTools.darkAccentColor),
                                          ),
                                        ],
                                      )))
                                  .toList())
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_shipping,
                      size: 35,
                      color: MyTools.darkAccentColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          style: MyTools.regular(
                              size: 12, color: MyTools.darkAccentColor),
                          text: result.kurirKode.toString().toUpperCase() +
                              "(${result.kurirService})",
                        ),
                        TextSpan(
                            style: MyTools.regular(
                                size: 11, color: MyTools.darkAccentColor),
                            text: "\nRp " +
                                MyTools.priceFormat(
                                    int.parse(result.kurirOngkir)))
                      ]),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total Harga",
                      style: MyTools.regular(
                          size: 12, color: MyTools.darkAccentColor),
                    ),
                    Text(
                      "-",
                      style: MyTools.regular(
                          size: 12, color: MyTools.darkAccentColor),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  void _openPopupAcceptOrder(context, String mitraId, String transactionId) {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "1-5 Estimasi"),
                ),
                MaterialButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      print("value is : " + controller.text);
                    } else {
                      print("value is empty");
                    }
                  },
                  child: Text("Terima Pesanan"),
                )
              ],
            ),
          );
        });
  }

  @override
  MitraOrderPageState createState() => this;
}
