import 'package:firebase_flutter/ui/auth/login_screen.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/round_button.dart';

class RegistenScreen extends StatefulWidget {

  @override
  State<RegistenScreen> createState() => _RegistenScreenState();
}

class _RegistenScreenState extends State<RegistenScreen> {
  bool loading=false;

  var nameController=TextEditingController();

  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  var _formKey=GlobalKey<FormState>();

  FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Register',style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.deepPurple,
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
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(

                        label: Text('Name'),
                        prefixIcon: Icon(Icons.account_circle),
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
            SizedBox(height: 50,),

            RoundButton(title: 'Login',loading: loading,onTap: (){

              if(_formKey.currentState!.validate()){
                register();
              }
              nameController.text="";
              emailController.text="";
              passwordController.text="";
            },),
            SizedBox(height: 30,),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Text("Already have an account?"),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              }, child: Text('Sign In')),
            ],
            ),
          ],
        ),
      ),
    );
  }

  void register() {
    setState(() {
      loading=true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      setState(() {
        loading=false;
      });
      Utils.toastMessage("Registered successfully", Colors.green);
    }).onError((error,stackTrance){
      Utils.toastMessage(error.toString(),Colors.red);
      setState(() {
        loading=false;
      });
    });
  }

}
