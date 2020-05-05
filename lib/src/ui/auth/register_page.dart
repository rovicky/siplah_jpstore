import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/register/register_bloc.dart';
import 'package:siplah_jpmall/src/bloc/register/register_state.dart';
import 'package:siplah_jpmall/src/ui/auth/login_page.dart';
import 'package:siplah_jpmall/src/ui/pick_address_page.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class Register extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<Register> with RegisterState{
  int thisPage = 0;
  final bloc = RegisterBloc();

  final nama = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final konfirmasi = TextEditingController();
  final telp = TextEditingController();
  final npsn = TextEditingController();
  final fullAddress = TextEditingController();
  final postalCode = TextEditingController();
  String slctdKatPel;
  String selectedAccountType;

  String province, idProvince, district, idDistrict, subDistrict, idSubDistrict;

  @override
  Widget build(BuildContext context) {
    List<Widget> widget1 = [
      _customTileWidget(
          context,
          DropdownButtonHideUnderline(
            child: DropdownButton(
                // dropdownColor: Colors.white,

                isExpanded: true,
                value: selectedAccountType,
                hint: Text(
                  "pilih pelanggan",
                  style:
                      MyTools.regular(size: 16, color: MyTools.darkAccentColor),
                ),
                items: ["3", "2"]
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(
                            e == '2' ? "Sekolah" : "Mitra",
                            style: MyTools.regular(
                                color: MyTools.darkAccentColor, size: 16),
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (item) {
                  setState(() {
                    selectedAccountType = item;
                  });
                }),
          ),
          "Daftar Sebagai ?"),
      selectedAccountType == null
          ? Container()
          : (selectedAccountType == "3")
              ? _customTileWidget(
                  context,
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      focusColor: Colors.white,
                        // dropdownColor: Colors.white,
                        isExpanded: true,
                        value: slctdKatPel,
                        hint: Text(
                          "pilih kategori pelanggan",
                          style: MyTools.regular(
                              size: 16, color: MyTools.darkAccentColor),
                        ),
                        items: ["1"]
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text(
                                    e == '1'
                                        ? "Berbadan Hukum"
                                        : "Perseorangan",
                                    style: MyTools.regular(
                                        color: MyTools.darkAccentColor,
                                        size: 16),
                                  ),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            slctdKatPel = item;
                          });
                        }),
                  ),
                  "Tipe")
              : _customTileTextField("NPSN", npsn,
                  isExpanded: false, isEditable: true, enable: true),
      _customTileTextField("Nama", nama,
          isExpanded: false, isEditable: true, enable: true),
      _customTileTextField("Email", email,
          isExpanded: false, isEditable: true, enable: true),
      _customTileTextField("Password", password,
          isExpanded: false, isEditable: true, enable: true, obSecure: true),
      _customTileTextField("Konfirmasi password", konfirmasi,
          isExpanded: false, isEditable: true, enable: true, obSecure: true),
      _customTileTextField("Telepon", telp,
          isExpanded: false,
          isEditable: true,
          enable: true,
          typeIsNumber: true),
      SizedBox(height: 15),
    ];

    List<Widget> widget2 = [
      GestureDetector(
        onTap: () async {
          var navResult = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PickAddressPage(
                      method: 2,
                    )),
          );
          if (navResult != null) {
            setState(() {
              province = navResult['title'];
              idProvince = navResult['id'];
            });
          }
        },
        child: _customTileWidget(
            context,
            Container(
              width: double.infinity,
              child: Text(
                province ?? "Provinsi belum dipilih",
                style:
                    MyTools.regular(size: 16, color: MyTools.darkAccentColor),
                textAlign: TextAlign.left,
              ),
            ),
            "Pilih Provinsi"),
      ),
      GestureDetector(
        onTap: idProvince == null
            ? () {}
            : () async {
                print(idProvince);
                var navResult = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PickAddressPage(
                            provinceId: idProvince,
                            method: 0,
                          )),
                );
                if (navResult != null) {
                  setState(() {
                    district = navResult['title'];
                    idDistrict = navResult['id'];
                  });
                }
              },
        child: _customTileWidget(
            context,
            Container(
              width: double.infinity,
              child: Text(
                district ?? "Kabupaten/Kota belum dipilih",
                style:
                    MyTools.regular(size: 16, color: MyTools.darkAccentColor),
                textAlign: TextAlign.left,
              ),
            ),
            "Pilih Kabupaten/Kota"),
      ),
      GestureDetector(
        onTap: idDistrict == null
            ? () {}
            : () async {
                var navResult = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PickAddressPage(
                            provinceId: idProvince,
                            districtId: idDistrict,
                            method: 1,
                          )),
                );
                if (navResult != null) {
                  setState(() {
                    subDistrict = navResult['title'];
                    idSubDistrict = navResult['id'];
                  });
                }
              },
        child: _customTileWidget(
            context,
            Container(
              width: double.infinity,
              child: Text(
                subDistrict ?? "Kecamatan belum dipilih",
                style:
                    MyTools.regular(size: 16, color: MyTools.darkAccentColor),
                textAlign: TextAlign.left,
              ),
            ),
            "Pilih Kecamatan"),
      ),
      _customTileTextField("Alamat", fullAddress,
          enable: true, isEditable: true, isExpanded: true),
      _customTileTextField("Kode Pos", postalCode,
          enable: true, isEditable: true)
    ];

    return Scaffold(
        backgroundColor: MyTools.primaryColor,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      image:
                          AssetImage("src/image/Icons_SIPLAH_JPSTORE_2020.png"),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Daftarkan Akunmu Disini",
                      style: MyTools.boldStyle(color: Colors.white, size: 18),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: thisPage == 0 ? widget1 : widget2,
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Builder(
          builder: (context) {
            return Container(
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black12,
                          child: Text(
                            thisPage == 0 ? "1" : "2",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: thisPage == 1
                            ? () {
                                setState(() {
                                  thisPage = 0;
                                });
                              }
                            : () {
                              Navigator.pop(context);
                            },
                        child: Text(
                          thisPage == 1 ? "Back" : "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        onPressed: thisPage == 0
                            ? () {
                                if (thisPage == 0) {
                                  setState(() {
                                    thisPage = 1;
                                  });
                                }
                              }
                            : () {
                          if (nama.text.isEmpty ||
                              email.text.isEmpty ||
                              password.text.isEmpty ||
                              konfirmasi.text.isEmpty ||
                              telp.text.isEmpty ||
                              idProvince.isEmpty ||
                              idDistrict.isEmpty ||
                              idSubDistrict.isEmpty ||
                              fullAddress.text.isEmpty ||
                              postalCode.text.isEmpty
                          ) {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Form Masih Kosong!", style: MyTools.regular(color: Colors.white, size: 14),)));
                          }else {
                            showDialog(context: context, builder: (context) => Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ));
                            if(selectedAccountType == "2") {
                              create({
                                "npsn":npsn.text,
                                "nama":nama.text,
                                "email":email.text,
                                "password":password.text,
                                "password_konfirmasi":konfirmasi.text,
                                "provinsi_id":idProvince,
                                "kabupaten_id":idDistrict,
                                "kecamatan_id":idSubDistrict,
                                "alamat":fullAddress.text,
                                "kode_pos":postalCode.text,
                                "telepon":telp.text
                              }).then((value) => _response(context, value));
                            }

                            create({
                              "type":slctdKatPel,
                              "kategori_pelanggan":"3",
                              "nama":nama.text,
                              "email":email.text,
                              "password":password.text,
                              "password_konfirmasi":konfirmasi.text,
                              "provinsi_id":idProvince,
                              "kabupaten_id":idDistrict,
                              "kecamatan_id":idSubDistrict,
                              "alamat":fullAddress.text,
                              "kode_pos":postalCode.text,
                              "telepon":telp.text
                            }).then((value) => _response(context, value));
                          }

                        },
                        child: Text(
                          thisPage == 0 ? "Next" : "Daftar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        ));
  }

  _response(context, Map<String, dynamic> result) {
    Navigator.pop(context);
    if(result['Error']) {
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text(result['Pesan_usr']),));
    }else{
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text("Berhasil Buat Akun, silahkan Login,..."),));
      Future.delayed(Duration(seconds: 1)).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())));
    }
  }

  _customTileTextField(String title, TextEditingController textController,
      {bool enable = false,
      bool isEditable = true,
      bool isExpanded = false,
      bool obSecure = false,
      bool typeIsNumber = false}) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: MyTools.boldStyle(size: 14, color: Colors.white),
            ),
          ],
        ),
      ),
      subtitle: Container(
        height: isExpanded ? null : 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: ListTile(
            title: TextField(
              keyboardType: (typeIsNumber) ? TextInputType.phone : null,
              obscureText: obSecure,
              enabled: enable,
              controller: textController,
              maxLines: isExpanded ? 5 : 1,
              style: MyTools.regular(color: MyTools.darkAccentColor, size: 16),
              decoration: InputDecoration(
                hintText: "Masukkan $title disini",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _customTileWidget(context, Widget child, String title,
      {bool isExpanded = false}) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: MyTools.boldStyle(size: 14, color: Colors.white),
            ),
          ],
        ),
      ),
      subtitle: Container(
        padding: const EdgeInsets.only(left: 15, right: 10),
        height: isExpanded ? null : 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(child: child),
      ),
    );
  }

  @override
  RegisterPageState createState() => this;
}
