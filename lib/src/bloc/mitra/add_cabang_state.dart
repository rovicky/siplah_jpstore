import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/models/mitra/cabang_model.dart';
import 'package:siplah_jpmall/src/ui/mitra/add_cabang_page.dart';

abstract class AddCabangState {
  AddCabangPageState createState();
  AddCabangPageState get _state => createState();
  MitraBloc get _bloc => _state.bloc;

  TextEditingController nama = TextEditingController();
  TextEditingController penanggungJawabNama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController konfirmasiPassword = TextEditingController();
  TextEditingController telepon = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController kodePos = TextEditingController();

  Future<Map<String, dynamic>> createCabang(Cabang cabang, {int mode}) => _bloc.createCabangMitra(cabang);

}