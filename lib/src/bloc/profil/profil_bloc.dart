import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/mitra_user.dart';
import 'package:siplah_jpmall/src/models/sekolah_user.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';

class ProfilBloc{
  final _provider = AuthProvider();
  PublishSubject<MitraUser> _mitraUser = PublishSubject<MitraUser>();
  PublishSubject<SekolahUser> _sekolahUser = PublishSubject<SekolahUser>();

  Stream<MitraUser> get mitraUser => _mitraUser.stream;
  Stream<SekolahUser> get sekolahUser => _sekolahUser.stream;

  getDataMitra(String id) async {
    MitraUser event = await _provider.fetchMitraUser(id);
    _mitraUser.sink.add(event);
  }

  getDataSekolah(String id) async {
    SekolahUser event = await _provider.fetchSekolahUser(id);
    _sekolahUser.sink.add(event);
  }

  dispose(){
    _mitraUser.close();
    _sekolahUser.close();
  }
}