import 'dart:io';

import 'package:siplah_jpmall/src/bloc/mitra/pick_foto_bloc.dart';
import 'package:siplah_jpmall/src/ui/add_product/form_pickFoto.dart';

abstract class PickFotoState {
  PickFotoPageState createState();
  PickFotoPageState get _state => createState();

  PickFotoBloc get _bloc => _state.bloc;

  Future<String> pickImage() async {
    return await _bloc.pickImage(_state.context);
  }
}
