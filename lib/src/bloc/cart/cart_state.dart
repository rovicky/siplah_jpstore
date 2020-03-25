import 'package:provider/provider.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';

import 'cart_bloc.dart';

abstract class CartState {
  CartsPageState createState();
  CartsPageState get _state => createState();

  CartBloc get _bloc => _state.bloc;

  firstLoad() async {
    _bloc.getData(await Provider.of<AuthProvider>(_state.context, listen: false).getCredential());
  }
}