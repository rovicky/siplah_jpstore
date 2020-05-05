import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class FormStock extends StatefulWidget {
  final Map<String, dynamic> value;

  const FormStock({Key key, this.value}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FormStockPageState();
}

class FormStockPageState extends State<FormStock> {
  TextEditingController _stok = TextEditingController();
  TextEditingController _sku = TextEditingController();
  int jenBar;
  bool alwaysOnStock = false;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      setState(() {
        _stok = TextEditingController(text: widget.value['stok']);
        _sku = TextEditingController(text: widget.value['sku']);
        jenBar = int.parse(widget.value['kondisi']);
        alwaysOnStock = widget.value['stok_slalu_ada'] == "1" ? true : false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Stok",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _widgetTextFieldTile(context,
                  controller: _sku, hint: "SKU (Stock Keeping Unit)"),
              _widgetTileDropdown(context),
              _widgetListTile(context,
                  child: CheckboxListTile(
                    activeColor: MyTools.primaryColor,
                    value: alwaysOnStock,
                    onChanged: (value) {
                      setState(() {
                        alwaysOnStock = value;
                      });
                    },
                    title: Text(
                      "Jadikan Selalu Ada Stock",
                      style: MyTools.regular(
                          size: 13, color: MyTools.darkAccentColor),
                    ),
                  ),
                  height: 55),
              !alwaysOnStock
                  ? _widgetTextFieldTile(context,
                      controller: _stok,
                      hint: "Masukkan Stok Produk Anda",
                      type: TextInputType.number)
                  : Container(),
              _widgetListTile(context,
                  key: "Submit",
                  color: MyTools.greenLand,
                  height: 55, onPressed: () {
                if (_sku.text.isNotEmpty ||
                    _stok.text.isNotEmpty ||
                    jenBar != null) {
                  Navigator.pop(context, {
                    "sku": _sku.text,
                    "stok": _stok.text,
                    "stok_slalu_ada": alwaysOnStock ? "1" : null,
                    "kondisi": jenBar.toString()
                  });
                } else {
                  print("is empty");
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  _widgetTileDropdown(context, {String key, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 55,
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
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              style: MyTools.regular(size: 13, color: MyTools.darkAccentColor),
              value: jenBar,
              hint: Text("Pilih Kondisi Barang"),
              items: [
                {"id": 1, "title": "Barang Baru"},
                {"id": 2, "title": "Barang Bekas"}
              ]
                  .map((x) => DropdownMenuItem(
                      value: x['id'],
                      child: Text(
                        x['title'],
                        style: MyTools.regular(
                            size: 13, color: MyTools.darkAccentColor),
                      )))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  jenBar = value;
                });
              }),
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
