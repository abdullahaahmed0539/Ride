 // ignore_for_file: deprecated_member_use

 import 'package:flutter/material.dart';
 dynamic snackBar(GlobalKey<ScaffoldState> scaffoldKey,String text) {
    return scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }