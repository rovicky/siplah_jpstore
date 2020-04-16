import 'package:siplah_jpmall/src/ui/mitra/mitra_page.dart';

abstract class MitraState {
  MitraPageState createState();
  MitraPageState get _state => createState();

}