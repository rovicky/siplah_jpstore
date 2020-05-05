import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/ui/mitra/mitra_order_page.dart';

abstract class MitraOrderState {
  MitraOrderPageState createState();
  MitraOrderPageState get _state => createState();
  MitraBloc get _bloc => _state.bloc;

  load(String mitraId) {
    _bloc.loadMitraOrderList(mitraId);
  }
}