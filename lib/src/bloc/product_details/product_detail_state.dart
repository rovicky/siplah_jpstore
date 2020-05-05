import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:siplah_jpmall/src/bloc/cart/cart_bloc.dart';
import 'package:siplah_jpmall/src/bloc/product_details/product_detail_bloc.dart';
import 'package:siplah_jpmall/src/bloc/produk_favorit/produk_favorit_bloc.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/ui/produk_detail.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

abstract class ProductDetailState {
  ProductDetailPageState createState();

  ProductDetailPageState get _state => createState();

  ProductDetailBloc get _bloc => _state.bloc;
  ProdukFavBloc get _fBloc => _state.fBloc;

  firstLoad(String id, String idUser,
      {String mitraId, String categoryId}) async {
    _bloc.getData(id, idUser);
//    _bloc.getProductFavorite(await Provider.of<AuthProvider>(_state.context, listen: false).getCredential(), id);
  }

  secondLoad(String idUser, {String mitraId, String categoryId}) {
    _bloc.getMoreProducts(idUser, categoryId: categoryId, mitraId: mitraId);
  }

  Future<bool> isFaved(String userId, String productId) =>
      _fBloc.isFavorited(productId, userId);
  addToFav(String id, String idUser) async {
    _fBloc.favorited(id, idUser).then((value) {
      if (value) {
        isFaved(idUser, id);
      } else {
        print("error");
      }
    });
  }

  deleteFav(String id, String userId) async {
    _fBloc.deleteData(id, userId).then((value) {
      if (value) {
        isFaved(userId, id);
      } else {
        print("error");
      }
    });
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

  Future<bool> createCart(String id, String mitraId, String userId,
      {int qty = 1}) async {
    return await CartBloc().create(id, userId, mitraId, qty: qty);
  }
}
