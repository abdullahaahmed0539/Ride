 import 'package:flutter/material.dart';
 dynamic snackBar(GlobalKey<ScaffoldState> scaffoldKey,String text) {
    // ignore: deprecated_member_use
    return scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }