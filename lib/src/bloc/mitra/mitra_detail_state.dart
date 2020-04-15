import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/ui/mitra/detail_mitra.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class MitraDetailState {
  DetailMitraPageState createState();

  DetailMitraPageState get _state => createState();

  MitraBloc get _bloc => _state.bloc;

  bool isExpanded1 = false;
  bool isExpanded2 = false;

  void firstLoad(String mitraId) {
    _bloc.getMitra(mitraId);
  }

  openMaps(double lat, double lng) async {
    if(await canLaunch("https://maps.google.com/?q=$lat,$lng")){
      await launch("https://maps.google.com/?q=$lat,$lng");
    }else{
      Scaffold.of(_state.context).showSnackBar(new SnackBar(content: Text("can't Launch Maps")));
    }
  }

  changeExpanded1() => _state.setState(() => isExpanded1 = !isExpanded1);
  changeExpanded2() => isExpanded2 = !isExpanded2;

}