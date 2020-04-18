import 'package:siplah_jpmall/src/resources/auth_provider.dart';

class RegisterBloc {
  final _provider = AuthProvider();

  Future<Map<String, dynamic>> register(Map<String, dynamic> result) async {
    return await _provider.createUser(result);
  }

}