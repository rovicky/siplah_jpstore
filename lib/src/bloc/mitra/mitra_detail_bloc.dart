import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/mitra_detail_model.dart';
import 'package:siplah_jpmall/src/resources/mitra_provider.dart';

class MitraDetailBloc {
  final _provider = MitraDetailProvider();
  final _mitraProfile = PublishSubject<MitraDetailModel>();

  Stream<MitraDetailModel> get mitraProfile => _mitraProfile.stream;

  void getMitra(String mitraId) async {
    MitraDetailModel mitra = await _provider.getMitra(mitraId);
    _mitraProfile.sink.add(mitra);
  }

  void dispose() {
    _mitraProfile.close();
  }
}