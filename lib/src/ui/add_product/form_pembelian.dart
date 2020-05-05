import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class Pembelian extends StatefulWidget {
  final Map<String, dynamic> value;

  const Pembelian({Key key, this.value}) : super(key: key);
  @override
  _PembelianState createState() => _PembelianState();
}

class _PembelianState extends State<Pembelian> {
  TextEditingController _minPurchase = TextEditingController();
  TextEditingController _kelipatan = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.value != null) {
      setState((){
        _minPurchase = TextEditingController(text: widget.value['pembelian_minimum']);
        _kelipatan = TextEditingController(text: widget.value['kelipatan_pembelian']);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Harga",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Pembelian Minimum (pcs)",
                style:
                    MyTools.regular(size: 13, color: MyTools.darkAccentColor),
              ),
              _widgetTextFieldTile(context,
                  controller: _minPurchase,
                  hint: "Masukkan minimum pembelian",
                  type: TextInputType.number),
              Text(
                "Kelipatan Pembelian (pcs)",
                style:
                    MyTools.regular(size: 13, color: MyTools.darkAccentColor),
              ),
              _widgetTextFieldTile(context,
                  controller: _kelipatan,
                  hint: "Masukkan kelipatan pembelian",
                  type: TextInputType.number),
              _widgetListTile(context,
                  key: "Submit",
                  color: MyTools.greenLand,
                  height: 60, onPressed: () {
                if (_minPurchase.text.isEmpty ||
                    _kelipatan.text.isEmpty) {
                  print("is Empty");
                } else {
                  Navigator.pop(context, {
                    "pembelian_minimum": _minPurchase.text,
                    "kelipatan_pembelian": _kelipatan.text,
                  });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
  
  _widgetListTile(context,
      {String key,
      Function onPressed,
      Widget child,
      double height,
      Color color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
        height: height ?? 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: child ??
            Center(
              child: ListTile(
                onTap: onPressed ?? () {},
                title: Text(key ?? "Tidak Ada Judul",
                    style: MyTools.boldStyle(
                        size: 14,
                        color: color != null
                            ? Colors.white
                            : MyTools.darkAccentColor)),
              ),
            ),
      ),
    );
  }

  _widgetTextFieldTile(context,
      {String key,
      TextEditingController controller,
      String hint,
      TextInputType type,
      bool isExpand = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
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
              title: TextField(
            controller: controller,
            expands: isExpand,
            keyboardType: type,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: MyTools.regular(
                    size: 12, color: MyTools.darkAccentColor.withOpacity(0.7))),
            style: MyTools.regular(size: 12, color: MyTools.darkAccentColor),
          )),
        ),
      ),
    );
  }
}