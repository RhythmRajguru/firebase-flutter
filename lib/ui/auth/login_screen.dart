import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/auth/login_with_phone.dart';
import 'package:firebase_flutter/ui/auth/registen_screen.dart';
import 'package:firebase_flutter/ui/forgot_password_Screen.dart';
import 'package:firebase_flutter/ui/posts/post_screen.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   var emailController=TextEditingController();
   var passwordController=TextEditingController();
   var _formKey=GlobalKey<FormState>();

   bool loading=false;

   FirebaseAuth _fAuth=FirebaseAuth.instance;
   @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Login',style: TextStyle(color: Colors.white),)),
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(

                        label: Text('Email'),
                        prefixIcon: Icon(Icons.alternate_email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(

                        label: Text('Password'),
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                ],
              ),),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                }, child: Text('Forget Password?',style: TextStyle(fontSize: 14),)),
              ),
              SizedBox(height: 30,),

              RoundButton(title: 'Login',loading:loading,onTap: (){
                if(_formKey.currentState!.validate()){
                 login();
                }
              },),
              SizedBox(height: 5,),
              SizedBox(height: 30,),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Text("Don't have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistenScreen(),));
                }, child: Text('Sign Up')),
              ],
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhone(),));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: Center(
                    child: Text('Continue with phone number'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    setState(() {
      loading=true;
    });
    _fAuth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
      Utils.toastMessage("Logged in Successfully ${value.user!.email.toString()}", Colors.green);
     Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));
      setState(() {
        loading=false;
      });
    }).onError((error,stackTrace){
      Utils.toastMessage(error.toString(), Colors.red);
      setState(() {
        loading=false;
      });
    });
  }
}
