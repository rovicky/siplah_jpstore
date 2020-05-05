import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class FormLainnya extends StatefulWidget {
  final Map<String, dynamic> value;

  const FormLainnya({Key key, this.value}) : super(key: key);
  @override
  _FormLainnyaState createState() => _FormLainnyaState();
}

class _FormLainnyaState extends State<FormLainnya> {
  int selectedTerbit;
  List<String> selectedJenjang = [];
  List<String> selectedKelas = [];
  List<String> jenjang = [
    "TK",
    "SD",
    "SMP",
    "SMA",
    "SMK",
  ];
  List<String> kelas = [
    "TK A",
    "TK B",
    "Kelas 1 (SD)",
    "Kelas 2 (SD)",
    "Kelas 3 (SD)",
    "Kelas 4 (SD)",
    "Kelas 5 (SD)",
    "Kelas 6 (SD)",
    "Kelas 7 (SMP)",
    "Kelas 8 (SMP)",
    "Kelas 9 (SMP)",
    "Kelas 10 (SMA)",
    "Kelas 11 (SMA)",
    "Kelas 12 (SMA)",
    "Kelas 10 (SMK)",
    "Kelas 11 (SMK)",
    "Kelas 12 (SMK)",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      setState(() {
        selectedJenjang = widget.value['jenjang'];
        selectedKelas = widget.value['kelas'];
        selectedTerbit = widget.value['terbit'];
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
          "Lainnya",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _widgetTileDropdown(context),
              _widgetListTile(context,
                  height: selectedJenjang.length == 0 ? 60 : null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: List.generate(
                          selectedJenjang.length,
                          (index) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.8)),
                                height: 30,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedJenjang.removeAt(index);
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      selectedJenjang[index],
                                      style: MyTools.regular(
                                          size: 12,
                                          color: MyTools.darkAccentColor),
                                    )
                                  ],
                                ),
                              )),
                    ),
                  )),
              _widgetListTile(context, key: "Pilih Jenjang",
                  onPressed: () async {
                final navItem = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Pilih(
                              selectedList: selectedJenjang.length == 0 ? null : selectedJenjang,
                              list: jenjang,
                            )));

                if (navItem != null) {
                  setState(() {
                    selectedJenjang.add(navItem);
                  });
                }
              }),
              _widgetListTile(context,
                  height: selectedKelas.length == 0 ? 60 : null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: List.generate(
                          selectedKelas.length,
                          (index) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.8)),
                                height: 30,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedKelas.removeAt(index);
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      selectedKelas[index],
                                      style: MyTools.regular(
                                          size: 12,
                                          color: MyTools.darkAccentColor),
                                    )
                                  ],
                                ),
                              )),
                    ),
                  )),
              _widgetListTile(context, key: "Pilih Kelas", onPressed: () async {
                final navItem = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Pilih(
                              selectedList: selectedKelas.length == 0 ? null : selectedKelas,
                              list: kelas,
                            )));

                if (navItem != null) {
                  setState(() {
                    selectedKelas.add(navItem);
                  });
                }
              }),
              _widgetListTile(context,
                  height: 60,
                  color: MyTools.greenLand,
                  key: "Submit", onPressed: () {
                Navigator.pop(context, {
                  "jenjang": selectedJenjang,
                  "kelas": selectedKelas,
                  "terbit": selectedTerbit
                });
              }),
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
              value: selectedTerbit,
              hint: Text("Terbit"),
              items: [
                {"id": 1, "title": "Ya"},
                {"id": 2, "title": "Tidak"}
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
                  selectedTerbit = value;
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
        height: height,
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
}

class Pilih extends StatelessWidget {
  final List<String> selectedList;
  final List<String> list;

  const Pilih({Key key, this.list, this.selectedList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  list.length,
                  (index) => _widgetListTile(context,
                      color: selectedList != null
                          ? (selectedList.contains(list[index]))
                              ? Colors.grey
                              : null
                          : null,
                      key: list[index],
                      onPressed: selectedList != null
                          ? (selectedList.contains(list[index]))
                              ? null
                              : () => Navigator.pop(context, list[index])
                          : () => Navigator.pop(context, list[index]))),
            ),
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
        height: height ?? 60,
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
}
