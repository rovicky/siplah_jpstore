
import 'package:siplah_jpmall/src/bloc/home/home_bloc.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/page_home.dart';

abstract class HomeState {
  HomePageState createState();

  HomePageState get _state => createState();

  HomeBloc get _bloc => _state.bloc;

//  User get theUser => _state.user;


  firstLoad(String id) async {
    _bloc.getData(id);
  }
}