import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/ui/mitra/marketing_page.dart';

abstract class MarketingState {
  MarketingPageState createState();
  MarketingPageState get _state => createState();

  MitraBloc get _bloc => _state.bloc;

  delete(String mitraId, String id) async {
    final result = await _bloc.deleteMarketing(mitraId, id);
    if(!result['Error']) {
      print("berhasil");
      load(mitraId);
    }else {
      print("gagal");
    }
  }

  load(String mitraId) {
    _bloc.getMarketing(mitraId);
  }
}