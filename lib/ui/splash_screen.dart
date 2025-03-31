import 'package:firebase_flutter/firebase_services/splash_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  SplashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       child: Center(child: Text('Hello')),
     ),
    );
  }
}
