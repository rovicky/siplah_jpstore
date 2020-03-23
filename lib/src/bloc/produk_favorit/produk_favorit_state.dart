import 'package:provider/provider.dart';
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_bloc.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';

import '../../ui/produk_favorit.dart';

abstract class ProductFavState {
  ProdukFavoritState createState();

  ProdukFavoritState get _state => createState();

  ProdukFavBloc get _bloc => _state.bloc;

  firstLoad() async {
    _bloc.getData(await Provider.of<AuthProvider>(_state.context, listen: false).getCredential());
  }
}