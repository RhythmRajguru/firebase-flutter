import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/auth/verify_code.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading=false;
  final auth=FirebaseAuth.instance;
  final phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: phoneController,
              decoration: InputDecoration(
                hintText: '+1 234 3455 234',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Login', loading: loading,onTap: (){
              setState(() {
                loading=true;
              });
            auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
                verificationCompleted: (_){
                  setState(() {
                    loading=false;
                  });
                },
                verificationFailed: (e){
                  setState(() {
                    loading=false;
                  });
                Utils.toastMessage(e.toString(), Colors.red);

                },
                codeSent: (String verificationId,int? token){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCode(verificationId: verificationId,),));
                  setState(() {
                    loading=false;
                  });
                },
                codeAutoRetrievalTimeout: (e){
                  Utils.toastMessage(e.toString(), Colors.red);
                  setState(() {
                    loading=false;
                  });
                });
            })
          ],
        ),
      ),
    );
  }
}
