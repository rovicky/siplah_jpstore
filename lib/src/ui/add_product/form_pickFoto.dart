import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/pick_foto_bloc.dart';
import 'package:siplah_jpmall/src/bloc/mitra/pick_foto_state.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class PickFoto extends StatefulWidget {
  final Map<String, dynamic> fotos;

  const PickFoto({Key key, this.fotos}) : super(key: key);
  @override
  PickFotoPageState createState() => PickFotoPageState();
}

class PickFotoPageState extends State<PickFoto> with PickFotoState {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.5);
  final bloc = PickFotoBloc();
  List<Map<String, dynamic>> fotos = [];

  @override
  void initState() {
    super.initState();
    if (widget.fotos != null) {
      fotos = widget.fotos['foto'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Pilih Foto",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 250,
                child: PageView(
                  controller: pageController,
                  children: <Widget>[
                    for (var foto in fotos)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.memory(base64.decode(foto['foto'])),
                      ),
                    Container(
                      height: 50,
                      width: 50,
                      child: Center(
                          child: IconButton(
                        onPressed: () {
                          pickImage().then((image) {
                            if (image != null) {
                              setState(() {
                                fotos.add({"foto": image});
                              });
                            }
                          });
                        },
                        icon: Icon(Icons.add_a_photo),
                      )),
                    )
                  ],
                  scrollDirection: Axis.horizontal,
                ),
              ),
              _widgetListTile(context, key: "Submit", onPressed: () {
                Navigator.pop(context, {
                  "foto": fotos,
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  _widgetListTile(context, {String key, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
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
          color: MyTools.greenLand,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: onPressed ?? () {},
            title: Text(key ?? "Tidak Ada Judul",
                style: MyTools.boldStyle(
                    size: 13, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  @override
  PickFotoPageState createState() => this;
}
