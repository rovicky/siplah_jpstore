import 'package:provider/provider.dart';
import 'package:siplah_jpmall/src/bloc/home/home_bloc.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/page_home.dart';

abstract class HomeState {
  HomePageState createState();

  HomePageState get _state => createState();

  HomeBloc get _bloc => _state.bloc;

//  User get theUser => _state.user;


  firstLoad() async {
    _bloc.getData(await Provider.of<AuthProvider>(_state.context, listen: false).getCredential());
//    Provider.of<AuthProvider>(_state.context).getUserInfo();
  }
}