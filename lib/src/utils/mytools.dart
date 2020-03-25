import 'package:intl/intl.dart';

class MyTools{
  static String priceFormat(int value){
    var f = NumberFormat("#,##0", "en_US");
    return f.format(value);
  }
}