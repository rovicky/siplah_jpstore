import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/ui/mitra/pick_marketing_page.dart';

abstract class PickMarketingState {
  PickMarketingPageState createState();

  PickMarketingPageState get _state => createState();

  MitraBloc get _bloc => _state.bloc;

  load(String mitraId) {
    _bloc.getMarketing(mitraId);
  }
}