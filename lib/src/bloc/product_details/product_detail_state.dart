import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:siplah_jpmall/src/bloc/product_details/product_detail_bloc.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';

abstract class ProductDetailState {
  ProductDetailPageState createState();

  ProductDetailPageState get _state => createState();

  ProductDetailBloc get _bloc => _state.bloc;

  firstLoad(String id, String idUser, {String mitraId, String categoryId}) async {
    _bloc.getData(id, idUser);
//    _bloc.getProductFavorite(await Provider.of<AuthProvider>(_state.context, listen: false).getCredential(), id);
  }

  secondLoad(String idUser, {String mitraId, String categoryId}) {
    _bloc.getMoreProducts(idUser, categoryId: categoryId, mitraId: mitraId);
  }

  addToFav(String id, String idUser) async {
    _bloc.addToFavorite(idUser, id);
    _bloc.getProductFavorite(idUser, id);
  }

  Future<void> share(String productName) async {
    await FlutterShare.share(
        title: productName,
        text: productName,
        linkUrl: "https://siplah.jpstore.id/search/?q=" +
            productName
                .replaceAll(" ", "+")
                .replaceAll(",", "%2C")
                .replaceAll(":", "%3A"),
        chooserTitle: productName);
  }

}