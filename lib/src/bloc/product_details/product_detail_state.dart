import 'package:provider/provider.dart';
import 'package:siplah_jpmall/src/bloc/product_details/product_detail_bloc.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';

abstract class ProductDetailState {
  DetailProduk2State createState();

  DetailProduk2State get _state => createState();

  ProductDetailBloc get _bloc => _state.bloc;

  firstLoad(String id) async {
    _bloc.getData(id, await Provider.of<AuthProvider>(_state.context, listen: false).getCredential());
//    _bloc.getProductFavorite(await Provider.of<AuthProvider>(_state.context, listen: false).getCredential(), id);
  }

  addToFav(String id) async {
    _bloc.addToFavorite(await Provider.of<AuthProvider>(_state.context, listen: false).getCredential(), id);
    _bloc.getProductFavorite(await Provider.of<AuthProvider>(_state.context, listen: false).getCredential(), id);
  }


}