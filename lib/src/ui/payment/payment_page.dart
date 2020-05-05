import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/address/address_bloc.dart';
import 'package:siplah_jpmall/src/bloc/my_order/order_bloc.dart';
import 'package:siplah_jpmall/src/bloc/my_order/payment_state.dart';
import 'package:siplah_jpmall/src/models/address_model.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/models/payment/payment_method.dart';
import 'package:siplah_jpmall/src/models/payment_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/mitra/pick_marketing_page.dart';
import 'package:siplah_jpmall/src/ui/payment/pick_cost.dart';
import 'package:siplah_jpmall/src/ui/payment/pick_payment_method.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class PaymentPage extends StatefulWidget {
  final CartModel result;
  final String id;
  final UserData user;

  const PaymentPage({Key key, this.id, this.user, @required this.result})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> with PaymentState {
  final oBloc = OrderBloc();
  final aBloc = AddressBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> listCourier = [];
  List<Map<String, dynamic>> listRefrence = [];
  List<PaymentMethod> listPayment = [];
  var token = '';

  @override
  void initState() {
    super.initState();
    tokenSet();
  }

  void tokenSet() async {
    loadToken().then((value){
      setState((){
        token = value;
      });
    });

    loadPayment(this.widget.user.id, this.widget.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: MyTools.darkAccentColor,
            ),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pesanan",
          style: MyTools.boldStyle(color: MyTools.darkAccentColor, size: 18),
        ),
      ),
      body: StreamBuilder<PaymentModel>(
          stream: oBloc.payment,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error) {
                return MyTools.errorWidget(context,
                    message: snapshot.data.pesanUsr);
              } else if (snapshot.data.data.length == 0) {
                return MyTools.errorWidget(context,
                    message: "Maaf Transaksi kamu tidak ada!");
              }
              return SingleChildScrollView(
                child: _body(context, snapshot.data),
              );
            } else if (snapshot.hasError) {
              return MyTools.errorWidget(context,
                  message: snapshot.error.toString());
            }
            return Center(child: MyTools.loadingWidget);
          }),
    );
  }

  _body(context, PaymentModel result) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(this.widget.result.data.length, (indexs) {
              if (listCourier.length < this.widget.result.data.length) {
                listCourier.add({"id": null});
                listRefrence.add({"id": null});
                listPayment.add(PaymentMethod(null));
              }

              return Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 4, top: 4),
                child: GestureDetector(
//        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderDetailPage(user: this.widget.user, id: result.,))),
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
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(this
                                                .widget
                                                .result
                                                .data[indexs]
                                                .foto ??
                                            BaseUrl.baseImage))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                      child: Text(
                                        this
                                                    .widget
                                                    .result
                                                    .data[indexs]
                                                    .nama
                                                    .length <
                                                25
                                            ? this
                                                .widget
                                                .result
                                                .data[indexs]
                                                .nama
                                            : this
                                                .widget
                                                .result
                                                .data[indexs]
                                                .nama
                                                .substring(0, 25),
                                        style: MyTools.boldStyle(
                                            size: 12,
                                            color: MyTools.darkAccentColor),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                              (1 / 2) +
                                          30),
                                  Container(
                                      child: Text(
                                        this
                                            .widget
                                            .result
                                            .data[indexs]
                                            .kabupatenNama,
                                        style: MyTools.regular(
                                            size: 11,
                                            color: MyTools.darkAccentColor),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                              (1 / 2) +
                                          30),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                              this.widget.result.data[indexs].produk.length < 2
                                  ? this
                                      .widget
                                      .result
                                      .data[indexs]
                                      .produk
                                      .length
                                  : 2, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 2,
                                      color: MyTools.darkAccentColor
                                          .withOpacity(0.5)),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(this
                                                            .widget
                                                            .result
                                                            .data[indexs]
                                                            .produk[index]
                                                            .produkFoto[0]
                                                            .foto ??
                                                        BaseUrl.baseImage))),
                                          ),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                this
                                                            .widget
                                                            .result
                                                            .data[indexs]
                                                            .produk[index]
                                                            .produkNama
                                                            .length <
                                                        25
                                                    ? this
                                                        .widget
                                                        .result
                                                        .data[indexs]
                                                        .produk[index]
                                                        .produkNama
                                                    : this
                                                            .widget
                                                            .result
                                                            .data[indexs]
                                                            .produk[index]
                                                            .produkNama
                                                            .substring(0, 25) +
                                                        "...",
                                                style: MyTools.boldStyle(
                                                    size: 12,
                                                    color: MyTools
                                                        .darkAccentColor),
                                              ),
                                              Text(
                                                this
                                                        .widget
                                                        .result
                                                        .data[indexs]
                                                        .produk[index]
                                                        .jumlah +
                                                    "x | Rp " +
                                                    MyTools.priceFormat(
                                                        int.parse(this
                                                            .widget
                                                            .result
                                                            .data[indexs]
                                                            .produk[index]
                                                            .produkHarga)),
                                                style: MyTools.regular(
                                                    color: Colors.redAccent,
                                                    size: 11),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        this.widget.result.data[indexs].produk.length > 2
                            ? Text("Lihat Semua")
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Divider(
                            height: 2,
                          ),
                        ),
                        _customListTile({
                          "title": (listCourier.length == 0)
                              ? ""
                              : !listCourier[indexs].containsKey("courier_name")
                                  ? "Pilih Ongkir"
                                  : listCourier[indexs]['courier_name'],
                          "subtitle": (listCourier.length == 0)
                              ? ""
                              : !listCourier[indexs].containsKey("service")
                                  ? "tekan untuk memilih kurir"
                                  : listCourier[indexs]["service"],
                          "onPressed": () async {
                            final navResult = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PickCost(data: {
                                          "destination": result
                                              .data[indexs].tujuanKecamatanId,
                                          "origin":
                                              result.data[indexs].kecamatanId,
                                          "weight":
                                              result.data[indexs].totalBerat
                                        })));

                            print("hello 2");

                            if (navResult != null) {
                              Map<String, dynamic> courier = {
                                "service": navResult['service'],
                                "courier_name": navResult['courier_name'],
                                "courier_code": navResult['courier_code'],
                                "cost": navResult['cost'],
                                "etd": navResult['etd'],
                                "mitra_id": result.data[indexs].mitraId
                              };
                              setState(() {
                                listCourier[indexs] = courier;
                              });
                              print(courier);
                            }

                            print(navResult);
                          },
                        }),
                        _customListTile({
                          "title": (listRefrence.length == 0)
                              ? ""
                              : listRefrence[indexs]['id'] == null
                                  ? "Pilih Refrensi"
                                  : listRefrence[indexs]['code'],
                          "subtitle": (listRefrence.length == 0)
                              ? ""
                              : listRefrence[indexs]['id'] == null
                                  ? "tekan untuk memilih marketing"
                                  : listRefrence[indexs]['name'],
                          "onPressed": () async {
                            final navResult = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PickMarketingPage(
                                          mitraId: result.data[indexs].mitraId,
                                        )));

                            if (navResult != null) {
                              setState(() {
                                listRefrence[indexs] = {
                                  "id": navResult['id'],
                                  "name": navResult['name'],
                                  "code": navResult['code'],
                                  "mitra_id": result.data[indexs].mitraId
                                };
                              });
                            }
                          }
                        }),
                        _customListTile({
                          "title": listRefrence.length == 0
                              ? ""
                              : listPayment[indexs].displayName ??
                                  "Metode Pembayaran",
                          "subtitle": listRefrence.length == 0
                              ? ""
                              : listPayment[indexs].bankName ??
                                  "tekan untuk memilih pembayaran",
                          "onPressed": () async {
                            final navResult = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PickPaymentMethod()));

                            if (navResult != null) {
                              setState(() {
                                listPayment[indexs] = navResult;
                              });
                            }
                          }
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Harga :",
                              style: MyTools.regular(
                                  size: 12, color: MyTools.darkAccentColor),
                            ),
                            Text(
                              "Rp" +
                                  MyTools.priceFormat(int.parse(
                                      result.data[indexs].subTotalProduk)),
                              style: MyTools.regular(
                                  size: 12, color: MyTools.darkAccentColor),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Ongkir",
                              style: MyTools.regular(
                                  size: 12, color: MyTools.darkAccentColor),
                            ),
                            Text(
                              listCourier.length == 0
                                  ? ""
                                  : (listCourier[indexs].containsKey('cost'))
                                      ? "Rp" +
                                          MyTools.priceFormat(
                                              listCourier[indexs]['cost'])
                                      : "Belum Dipilih",
                              style: MyTools.regular(
                                  size: 12, color: MyTools.darkAccentColor),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })),
        SizedBox(
          height: 10,
        ),
        _buttonNegosiasi(),
        SizedBox(
          height: 10,
        ),
        _buttonCreateOrder(result),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _address(context) {
    return StreamBuilder<AddressModel>(
        stream: aBloc.adressList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error, can't load anything!"),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data.error) {
              return Center(
                child: Text("Error, ${snapshot.data.message}"),
              );
            } else if (snapshot.data.data.length == 0) {
              return Center(
                child: Text("Belum Ada Alamat yang ditambahkan"),
              );
            }
            return Text(snapshot.data.data[0].nama);
          }
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
  }

  _buttonNegosiasi() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          border: Border.all(width: 2, color: Color(0xFF2BD6A2)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: () {},
            title: Center(
              child: Text(
                "Negoisasi",
                textAlign: TextAlign.center,
                style: MyTools.boldStyle(color: Color(0xFF2BD6A2), size: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonCreateOrder(PaymentModel result) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Color(0xFF2BD6A2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              var ongkir = 0;
              for (var i in listCourier) {
                if (i['cost'] == null) {
                  _scaffoldKey.currentState.showSnackBar(
                      new SnackBar(content: Text("Kurir not selected")));
                } else {
                  ongkir += int.parse(i['cost'].toString());
                }
              }

              var product = 0;
              for(var i in result.data) {
                product += int.parse(i.subTotalProduk.toString());
              }

              print(product.toString());
              purchase(
                this.widget.user,
                courier: listCourier.map((f) {
                  return {
                    "mitra_id":f['mitra_id'],
                    "kurir":"2",
                    "kurir_id":f['courier_code'],
                    "kurir_service":f['service'],
                    "kurir_service_deskripsi":"",
                    "ongkir":f['cost'],
                  };
                }).toList(),
                transactionId: this.widget.id,
                marketing: listRefrence.map((f){
                  return {
                    "marketing_id":f['marketing_id'],
                    "mitra_id":f['mitra_id']
                  };
                }).toList(),
                detail: {
                  "total_ongkir": ongkir,
                  "sub_total": product,
                  "user_id":this.widget.user.id,
                  "token_id": token??''
                }
              );
            },
            title: Center(
              child: Text(
                "Buat Pesanan",
                textAlign: TextAlign.center,
                style: MyTools.boldStyle(color: Colors.white, size: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _customListTile(Map<String, dynamic> child) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
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
                        size: 11, color: MyTools.darkAccentColor),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  PaymentPageState createState() => this;
}
