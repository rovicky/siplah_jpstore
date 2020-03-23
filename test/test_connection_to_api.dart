import 'package:flutter_test/flutter_test.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/resources/produk_favorit_provider.dart';

void main(){
  ProductFavProvider p;
  p = ProductFavProvider();

  test("hello", () async {
//    p.fetchProducts("47").then((value) => print(value.error));
  final Products products = await p.fetchProducts("47");
    expect(products.error, false);
  });
}