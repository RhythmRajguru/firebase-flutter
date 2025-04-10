import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utils{
  static void toastMessage(String message,Color backColor){
    Fluttertoast.showToast(
        msg: message,toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,timeInSecForIosWeb: 1,
    backgroundColor: backColor,textColor: Colors.white,
    fontSize: 16.0);
  }
}