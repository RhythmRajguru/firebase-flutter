import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final postController=TextEditingController();
  bool loading=false;
  final databaseRef=FirebaseDatabase.instance.ref('Post');//database table name
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
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
            databaseRef.child(id).set({
              'id':id,
              'title':postController.text.toString()
            }).then((value){
              Utils.toastMessage("Saved Successfully", Colors.green);
              postController.text='';
              setState(() {
                loading=false;
              });
            }).onError((error,stackTrace){
              Utils.toastMessage(error.toString(), Colors.red);
              postController.text='';
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
