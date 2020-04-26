import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/models/payment/payment_method.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class PickPaymentMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Metode Pembayaran", style: MyTools.boldStyle(
          color: MyTools.darkAccentColor,
          size: 18
        ),), elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: List.generate(listPayment.length, (index) => _customListTile(context, listPayment[index])),
        ),
      ),
    );
  }

  _customListTile(BuildContext context, PaymentMethod payment) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7, left: 10, right: 10),
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
            trailing: Container(
              height: 20,
                child: Image.network(payment.url ?? BaseUrl.baseImage, fit: BoxFit.cover,)),
            onTap: () {
              Navigator.pop(context, payment);
            },
            title: Text(
              payment.displayName,
              style:
              MyTools.boldStyle(color: MyTools.darkAccentColor, size: 14),
            ),
          ),
        ),
      ),
    );
  }

}