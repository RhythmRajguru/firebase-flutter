import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widgets/round_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {
  final postController=TextEditingController();
  bool loading=false;
  final firestore=FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Add',loading: loading ,onTap: (){
              setState(() {
                loading=true;
              });
              String id=DateTime.now().millisecondsSinceEpoch.toString();
              firestore.doc(id).set({
                'id':id,
                'title':postController.text.toString()
              }).then((value){
                Utils.toastMessage('Added Successfully', Colors.green);
                setState(() {
                  loading=false;
                });
                postController.text='';
              }).onError((error,stackTrace){
                Utils.toastMessage(error.toString(), Colors.red);
                setState(() {
                  loading=false;
                });
                postController.text='';
              });
          
            })
          ],
        ),
      ),
    );
  }

}
