import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/mitra_detail_model.dart';
import 'package:siplah_jpmall/src/models/mitra_list_model.dart';
import 'package:siplah_jpmall/src/resources/mitra_provider.dart';

class MitraBloc {
  final _provider = MitraDetailProvider();
  final _mitraProfile = PublishSubject<MitraDetailModel>();
  final _mitraList = PublishSubject<MitraListModel>();

  Stream<MitraDetailModel> get mitraProfile => _mitraProfile.stream;
  Stream<MitraListModel> get mitraList => _mitraList.stream;

  void getMitra(String mitraId) async {
    MitraDetailModel mitra = await _provider.getMitra(mitraId);
    _mitraProfile.sink.add(mitra);
  }

  void getListMitra() async {
    MitraListModel event = await _provider.getMitras();
    _mitraList.sink.add(event);
  }

  void dispose() {
    _mitraProfile.close();
    _mitraList.close();
  }
}