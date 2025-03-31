import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widgets/round_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter email',
                border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundButton(title: 'Forgot', onTap: (){
            auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
              Utils.toastMessage("Email sent Successfully", Colors.green);
              emailController.text='';
            }).onError((error,stackTrace){
              Utils.toastMessage(error.toString(), Colors.red);
              emailController.text='';
            });
            }),
          )
        ],
      ),
    );
  }
}
