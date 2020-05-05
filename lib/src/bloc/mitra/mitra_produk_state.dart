import 'package:siplah_jpmall/src/models/mitra/product_mitra_model.dart';
import 'package:siplah_jpmall/src/ui/mitra/mitra_produk.dart';

abstract class MitraProdukState {
  MitraProductPageState createState();

  MitraProductPageState get _state => createState();

  List<ProductMitraModel> list = [];
}