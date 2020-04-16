import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_state.dart';
import 'package:siplah_jpmall/src/models/user.dart';

class MitraPage extends StatefulWidget {
  final UserData user;

  const MitraPage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MitraPageState();
}

class MitraPageState extends State<MitraPage> with MitraState {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  MitraPageState createState() => this;

}