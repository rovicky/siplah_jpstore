import 'package:flutter/material.dart';
import 'package:markd/markdown.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/models/mitra/product_mitra_model.dart';
import 'package:siplah_jpmall/src/ui/mitra/add_product_mitra.dart';
import 'package:zefyr/zefyr.dart';
import 'package:notus/convert.dart';
import 'package:html2md/html2md.dart' as html2md;

abstract class AddProductMitraState {
  AddProductMitraPageState createState();
  AddProductMitraPageState get _state => createState();

  MitraBloc get _bloc => _state.bloc;

  TextEditingController nameProduct = TextEditingController();
  // TextEditingController descriptionProduct = TextEditingController();
  TextEditingController skKementrian = TextEditingController();
  TextEditingController brand = TextEditingController();
  ZefyrController descriptionProduct = ZefyrController(NotusDocument());
  FocusNode focusNode = FocusNode();

  Future<String> change(String html) async {
    return markdownToHtml(html);
  }
  Future<NotusDocument> getDocument(String html) async {
    return NotusDocument.fromDelta(NotusMarkdownCodec().decode(html2md.convert(html)));
    // return NotusDocument.fromDelta(
    //         notusMarkdown.decode(html2md.convert(html)));
  }

  Future<Map<String, dynamic>> createProduct(ProductMitraModel model) async {
    return await _bloc.createProduct(model);
  }
  
}