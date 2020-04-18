import 'package:siplah_jpmall/src/bloc/register/register_bloc.dart';
import 'package:siplah_jpmall/src/ui/auth/register_page.dart';

abstract class RegisterState {
  RegisterPageState createState();
  RegisterPageState get _state => createState();

  RegisterBloc get _bloc => _state.bloc;

  Future<Map<String, dynamic>> create(Map<String, dynamic> result) async {
    return _bloc.register(result);
  }
}