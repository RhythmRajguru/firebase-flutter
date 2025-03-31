import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/auth/login_screen.dart';
import 'package:firebase_flutter/ui/firestore/firestore_list_screen.dart';
import 'package:firebase_flutter/ui/posts/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices{

  static void isLogin(BuildContext context){

    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;

    if(user != null){
      Timer(Duration(seconds: 1),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>FirestoreListScreen(),));
      });
    }
    else{
      Timer(Duration(seconds: 1),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen(),));
      });
    }
  }

}