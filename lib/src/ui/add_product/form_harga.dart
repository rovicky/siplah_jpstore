import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class FormHarga extends StatefulWidget {
  final Map<String, dynamic> value;
  final String categoryId;

  const FormHarga({Key key, this.value, this.categoryId}) : super(key: key);
  @override
  _FormHargaState createState() => _FormHargaState();
}

class _FormHargaState extends State<FormHarga> {
  TextEditingController _hargaSatuan = TextEditingController();
    TextEditingController _zone1 = TextEditingController();
    TextEditingController _zone2 = TextEditingController();
    TextEditingController _zone3 = TextEditingController();
    TextEditingController _zone4 = TextEditingController();
    TextEditingController _zone5 = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.categoryId == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Kategori belum dipilih"),
                content: Text("Silahkan pilih kategori terlebih dahulu"),
                actions: <Widget>[
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Tutup"),
                  )
                ],
              ));
    } else if (widget.value != null) {
      setState(() {
        _hargaSatuan = TextEditingController(text: widget.value['harga_satuan']);
        _zone1 = TextEditingController(text: widget.value['harga_zona'][0]['harga']);
        _zone2 = TextEditingController(text: widget.value['harga_zona'][1]['harga']);
        _zone3 = TextEditingController(text: widget.value['harga_zona'][2]['harga']);
        _zone4 = TextEditingController(text: widget.value['harga_zona'][3]['harga']);
        _zone5 = TextEditingController(text: widget.value['harga_zona'][4]['harga']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    List<Widget> _widgetNonK13 = [
      Text("Harga Satuan",
          style: MyTools.regular(size: 13, color: MyTools.darkAccentColor)),
      _widgetTextFieldTile(context,
          controller: _hargaSatuan,
          hint: "Masukkan Harga Satuan",
          type: TextInputType.number),
    ];
    List<Widget> _widgetK13 = [
      Text("Harga Zona (*Harga Termasuk Pajak yang Berlaku)",
          style: MyTools.regular(size: 13, color: MyTools.darkAccentColor)),
      _widgetTextFieldTile(context,
          controller: _zone1,
          hint: "Masukkan Harga Zona 1",
          type: TextInputType.number),
      _widgetTextFieldTile(context,
          controller: _zone2,
          hint: "Masukkan Harga Zona 2",
          type: TextInputType.number),
      _widgetTextFieldTile(context,
          controller: _zone3,
          hint: "Masukkan Harga Zona 3",
          type: TextInputType.number),
      _widgetTextFieldTile(context,
          controller: _zone4,
          hint: "Masukkan Harga Zona 4",
          type: TextInputType.number),
      _widgetTextFieldTile(context,
          controller: _zone5,
          hint: "Masukkan Harga Zona 5",
          type: TextInputType.number),
    ];
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
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children:
                      widget.categoryId != null && widget.categoryId == "7" ||
                              widget.categoryId == "13"
                          ? _widgetK13
                          : _widgetNonK13),
              _widgetListTile(context,
                  key: "Submit",
                  color: MyTools.greenLand,
                  height: 60, onPressed: () {
                Navigator.pop(context, {
                  "harga_satuan": _hargaSatuan.text ?? '',
                  "harga_zona": [
                    {"id": 1, "harga": _zone1.text ?? ''},
                    {"id": 2, "harga": _zone2.text ?? ''},
                    {"id": 3, "harga": _zone3.text ?? ''},
                    {"id": 4, "harga": _zone4.text ?? ''},
                    {"id": 5, "harga": _zone5.text ?? ''},
                  ],
                });
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
