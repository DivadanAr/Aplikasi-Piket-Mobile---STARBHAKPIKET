import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String? text){
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red,);

    Utils.messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
