import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/add_cabang_state.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/bloc/mitra/pick_foto_bloc.dart';
import 'package:siplah_jpmall/src/models/mitra/cabang_model.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/pick_address_page.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class AddCabangPage extends StatefulWidget {
  final UserData user;
  final Cabang cabang;

  const AddCabangPage({Key key, this.user, this.cabang}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AddCabangPageState();
}

class AddCabangPageState extends State<AddCabangPage> with AddCabangState {
  final bloc = MitraBloc();
  String foto, province, pid, district, did, subDistrict, sdid, imgUrl;
  final key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (widget.cabang != null) {
      setState(() {
        nama = TextEditingController(text: widget.cabang.nama);
        email = TextEditingController(text: widget.cabang.email);
        telepon = TextEditingController(text: widget.cabang.telepon);
        penanggungJawabNama =
            TextEditingController(text: widget.cabang.namaPenanggungJawab);
        alamat = TextEditingController(text: widget.cabang.alamat);
        kodePos = TextEditingController(text: widget.cabang.kodePos);
        imgUrl = widget.cabang.foto;
        province = widget.cabang.namaProvinsi;
        pid = widget.cabang.provinsiId;
        district = widget.cabang.namaKabupaten;
        did = widget.cabang.kabupatenId;
        subDistrict = widget.cabang.namaKecamatan;
        sdid = widget.cabang.kecamatanId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Tambah Cabang",
            style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _widgetFoto(context),
              _widgetTextFieldTile(context,
                  controller: nama, hint: "Masukkan Nama"),
              _widgetTextFieldTile(context,
                  controller: penanggungJawabNama,
                  hint: "Masukkan Nama Penanggung Jawab"),
              _widgetTextFieldTile(context,
                  controller: email,
                  hint: "Masukkan Email",
                  type: TextInputType.emailAddress),
              _widgetTextFieldTile(context,
                  controller: telepon,
                  hint: "Masukkan Telepon",
                  type: TextInputType.phone),
              _widgetTextFieldTile(
                context,
                controller: password,
                hint: "Masukkan Password",
                obsecure: true,
              ),
              _widgetTextFieldTile(context,
                  controller: konfirmasiPassword,
                  hint: "Masukkan Konfirmasi Password",
                  obsecure: true),
              _widgetListTile(context, key: province ?? "Pilih Provinsi",
                  onPressed: () async {
                final navResult = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PickAddressPage(
                              method: 2,
                            )));
                if (navResult != null) {
                  setState(() {
                    province = navResult['title'];
                    pid = navResult['id'];
                  });
                }
              }),
              _widgetListTile(context, key: district ?? "Pilih Kabupaten/Kota",
                  onPressed: () async {
                final navResult = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PickAddressPage(
                              method: 0,
                              provinceId: pid,
                            )));
                if (navResult != null) {
                  setState(() {
                    district = navResult['title'];
                    did = navResult['id'];
                  });
                }
              }),
              _widgetListTile(context, key: subDistrict ?? "Pilih Kecamatan",
                  onPressed: () async {
                final navResult = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PickAddressPage(
                              method: 1,
                              provinceId: pid,
                              districtId: did,
                            )));
                if (navResult != null) {
                  setState(() {
                    subDistrict = navResult['title'];
                    sdid = navResult['id'];
                  });
                }
              }),
              _widgetTextFieldTileExpand(context,
                  controller: alamat,
                  hint: "Masukkan Alamat",
                  isExpand: true,
                  type: TextInputType.multiline),
              _widgetTextFieldTile(context,
                  controller: kodePos,
                  hint: "Masukkan Kode Pos",
                  type: TextInputType.number),
              _widgetListTile(context, color: MyTools.greenLand, key: "Submit",
                  onPressed: () {
                if(widget.cabang != null) {
                  createCabang(Cabang(
                          cabangUserId: this.widget.user.id,
                          foto: foto,
                          alamat: alamat.text,
                          email: email.text,
                          kabupatenId: did,
                          kecamatanId: sdid,
                          kodePos: kodePos.text,
                          konfirmasiPassword: konfirmasiPassword.text == '' ? null : konfirmasiPassword.text,
                          nama: nama.text,
                          namaKabupaten: district,
                          namaKecamatan: subDistrict,
                          namaPenanggungJawab: penanggungJawabNama.text,
                          namaProvinsi: province,
                          password: password.text == '' ? null : password.text,
                          provinsiId: pid,
                          telepon: telepon.text, id: widget.cabang.id), mode: 1)
                      .then((value) {
                    print(value);
                    if (!value['Error']) {
                      Navigator.pop(context);
                    } else {
                      key.currentState.showSnackBar(SnackBar(
                        content: Text(value['Pesan_usr']),
                      ));
                    }
                  });
                }else {
                  createCabang(Cabang(
                          cabangUserId: this.widget.user.id,
                          foto: foto,
                          alamat: alamat.text,
                          email: email.text,
                          kabupatenId: did,
                          kecamatanId: sdid,
                          kodePos: kodePos.text,
                          konfirmasiPassword: konfirmasiPassword.text,
                          nama: nama.text,
                          namaKabupaten: district,
                          namaKecamatan: subDistrict,
                          namaPenanggungJawab: penanggungJawabNama.text,
                          namaProvinsi: province,
                          password: password.text,
                          provinsiId: pid,
                          telepon: telepon.text,))
                      .then((value) {
                    print(value);
                    if (!value['Error']) {
                      Navigator.pop(context);
                    } else {
                      key.currentState.showSnackBar(SnackBar(
                        content: Text(value['Pesan_usr']),
                      ));
                    }
                  });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  _widgetFoto(context) {
    return SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                  image: DecorationImage(
                      image: imgUrl != null
                          ? NetworkImage(imgUrl)
                          : foto == null
                              ? AssetImage(BaseUrl.placeholder)
                              : MemoryImage(base64.decode(foto)))),
              height: 90,
              width: 90,
            ),
            Positioned(
              bottom: 5,
              right: 8,
              child: CircleAvatar(
                  backgroundColor: MyTools.primaryColor,
                  radius: 15,
                  child: Center(
                    child: IconButton(
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 14,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          PickFotoBloc().pickImage(context).then((value) {
                            setState(() {
                              foto = value;
                            });
                          });
                        }),
                  )),
            ),
          ],
        ));
  }

  _widgetListTile(context, {String key, Function onPressed, Color color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7, left: 10, right: 10),
      child: Container(
        height: 60,
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
        child: Center(
          child: ListTile(
            onTap: onPressed ?? () {},
            title: Text(key ?? "Tidak Ada Judul",
                style: MyTools.boldStyle(
                    size: 13,
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
      bool isExpand = false,
      TextInputType type,
      bool obsecure = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7, left: 10, right: 10),
      child: Container(
        height: isExpand ? 150 : null,
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
        child: ListTile(
            title: TextField(
          obscureText: obsecure ?? false,
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: MyTools.regular(
                  size: 12, color: MyTools.darkAccentColor.withOpacity(0.7))),
          style: MyTools.regular(size: 12, color: MyTools.darkAccentColor),
        )),
      ),
    );
  }

  _widgetTextFieldTileExpand(
    context, {
    String key,
    TextEditingController controller,
    String hint,
    bool isExpand = false,
    TextInputType type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7, left: 10, right: 10),
      child: Container(
        height: 150,
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
        child: ListTile(
            title: TextField(
          expands: true,
          maxLines: null,
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: MyTools.regular(
                  size: 12, color: MyTools.darkAccentColor.withOpacity(0.7))),
          style: MyTools.regular(size: 12, color: MyTools.darkAccentColor),
        )),
      ),
    );
  }

  @override
  AddCabangPageState createState() => this;
}
