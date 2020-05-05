import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class FormShip extends StatefulWidget {
  final Map<String, dynamic> value;

  const FormShip({Key key, this.value}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FormShipPageState();
}

class FormShipPageState extends State<FormShip> {
  TextEditingController _weight = TextEditingController();
  TextEditingController _height = TextEditingController();
  TextEditingController _width = TextEditingController();
  TextEditingController _length = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.value != null) {
      setState(() {
        _weight = TextEditingController(text: widget.value['berat']);
        _width = TextEditingController(text: widget.value['lebar']);
        _height = TextEditingController(text: widget.value['tinggi']);
        _length = TextEditingController(text: widget.value['panjang']);
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
          "Pengiriman Detail",
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
                "Berat (gram)",
                style:
                    MyTools.regular(size: 13, color: MyTools.darkAccentColor),
              ),
              _widgetTextFieldTile(context,
                  controller: _weight,
                  hint: "Masukkan Berat dalam gram",
                  type: TextInputType.number),
              Text(
                "Dimensi (cm)",
                style:
                    MyTools.regular(size: 13, color: MyTools.darkAccentColor),
              ),
              _widgetTextFieldTile(context,
                  controller: _length,
                  hint: "Masukkan Panjang dalam cm",
                  type: TextInputType.number),
              _widgetTextFieldTile(context,
                  controller: _width,
                  hint: "Masukkan Lebar dalam cm",
                  type: TextInputType.number),
              _widgetTextFieldTile(context,
                  controller: _height,
                  hint: "Masukkan Tinggi dalam cm",
                  type: TextInputType.number),
              _widgetListTile(context,
                  key: "Submit",
                  color: MyTools.greenLand,
                  height: 60, onPressed: () {
                if (_weight.text.isEmpty ||
                    _length.text.isEmpty ||
                    _height.text.isEmpty ||
                    _width.text.isEmpty) {
                  print("is Empty");
                } else {
                  Navigator.pop(context, {
                    "berat": _weight.text,
                    "lebar": _width.text,
                    "tinggi": _height.text,
                    "panjang": _length.text
                  });
                }
              })
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
