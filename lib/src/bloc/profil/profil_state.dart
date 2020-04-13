import 'package:siplah_jpmall/src/bloc/profil/profil_bloc.dart';
import 'package:siplah_jpmall/src/ui/auth/profil_page.dart';

abstract class ProfileState{
  ProfilPageState createState();

  ProfilPageState get _state => createState();

  ProfilBloc get _bloc => _state.bloc;

  firstLoad(String id, String levelId) {
    if(levelId == "2"){
      _bloc.getDataSekolah(id);
    }else{
      _bloc.getDataMitra(id);
    }
  }
}