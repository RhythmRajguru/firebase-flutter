import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  bool loading;
  RoundButton({required this.title,required this.onTap,this.loading=false,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 40,right: 40),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child:loading?CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :Text(title,style: TextStyle(color: Colors.white),),),
        ),
      ),
    );
  }
}
