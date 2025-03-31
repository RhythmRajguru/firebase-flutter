import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/posts/post_screen.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class VerifyCode extends StatefulWidget {
  String verificationId;

  VerifyCode({required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading=false;

  final auth=FirebaseAuth.instance;

  final otpController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: otpController,
              decoration: InputDecoration(
                  hintText: '6 digit code',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Verify', loading: loading,onTap: () async{
              setState(() {
                loading=true;
              });
              final authCredential=PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otpController.text.toString());
              try{
              await auth.signInWithCredential(authCredential);
              Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));
              Utils.toastMessage("Logged in Successfully", Colors.green);
              }catch(e){
                setState(() {
                  loading=false;
                });
                Utils.toastMessage(e.toString(), Colors.red);
              }
            })
          ],
        ),
      ),
    );

  }
}
