import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class LandingPage extends StatelessWidget {
  final bool error;
  final String message;
  final Widget child;

  const LandingPage({Key key, this.error, this.message, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          error ? _error(context) : _error(context),
          child ?? Container()
        ],
      )
    );
  }

  _error(context) {
    return MyTools.errorWidget(context, message: message);
  }
}