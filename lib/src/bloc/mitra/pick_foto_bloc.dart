import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:siplah_jpmall/src/ui/landing_page.dart';

class PickFotoBloc {
  Future<String> pickImage(BuildContext context) async {
    final bool _status = await checkService(PermissionGroup.mediaLibrary);
    if (!_status) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LandingPage(
                  error: true, message: "Permission Tidak Diizinkan")));
    }

    try {
      final File _image = await ImagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 10,
          maxHeight: 800,
          maxWidth: 800);
          // Random rand = Random();
          // _image.renameSync("siplah-mobile-${rand.nextInt(999999)}.jpg");
          var image = _image.readAsBytesSync();
      return base64.encode(image);
    } catch (e) {
      throw Exception("error");
    }
  }

  Future<Map<PermissionGroup, PermissionStatus>> getPermission(
      PermissionGroup permissionGroup) async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([permissionGroup]);
    return permissions;
  }

  Future<bool> checkService(PermissionGroup permissionGroup) async {
    final PermissionStatus _permissionStatus =
        await PermissionHandler().checkPermissionStatus(permissionGroup);
    if (_permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
