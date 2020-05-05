import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siplah_jpmall/src/models/product_detail.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class MyTools {
  static String priceFormat(int value) {
    var f = NumberFormat("#,##0", "en_US");
    return f.format(value);
  }

  static Widget loadingWidget = Center(
      child: Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              offset: Offset(0, 0),
              blurRadius: 10)
        ]),
    child: Center(
      child: CupertinoActivityIndicator(
        radius: 20,
      ),
    ),
  ));

  static TextStyle boldStyle(
          {double size = 13, Color color = Colors.black38}) =>
      TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
          color: color,
          fontSize: size,
          wordSpacing: 1.0,
          letterSpacing: 1.0);
  static TextStyle regular({double size = 13, Color color = Colors.black38}) =>
      TextStyle(
          fontFamily: 'Poppins',
          color: color,
          fontSize: size,
          wordSpacing: 1.0,
          letterSpacing: 1.0);

  static Color primaryColor = Color(0xFF007FFF);
  static Color primaryColorChild = Color(0xFF6BB8E3);
  static Color accentColor = Color(0xFF3FCB9B);
  static Color darkAccentColor = Color(0xFF173f5f);
  static Color redColor = Color(0xFFD62B31);
  static Color greenLand = Color(0xFF2BD6A2);

  static Widget errorWidget(BuildContext context,
          {String message = "Item Not Found!"}) =>
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 120,
              child: Image.asset("src/image/error.png"),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                message,
                style:
                    MyTools.boldStyle(color: MyTools.darkAccentColor, size: 20),
              ),
            )
          ],
        ),
      );

  static String getZonePrice(
      String myProvinceName, List<HargaZona> listZonaPrice) {
    var price = 'No data';
    for (var i in listZonaPrice) {
      if (i.provinsi.contains(myProvinceName)) {
        return i.harga;
//         break;
      }
    }
    return price.toString();
  }

  static EdgeInsetsGeometry defaultPadding(
          {double left: 10,
          double right: 10,
          double top: 0,
          double bottom: 0}) =>
      EdgeInsets.only(bottom: bottom, top: top, right: right, left: left);
  static Widget imageProvider(String imageUrl, BuildContext context,
          {double height: 100, double width: 100}) =>
      CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
//        fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(BaseUrl.baseImage),
//          fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
