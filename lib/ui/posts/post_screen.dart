import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_flutter/ui/auth/login_screen.dart';
import 'package:firebase_flutter/ui/posts/add_posts.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth=FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref('Post');
  final searchFilter=TextEditingController();
  final updateController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Post')),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              Utils.toastMessage("Logged out Successfully", Colors.green);
            }).onError((error,stackTrace){
              Utils.toastMessage(error.toString(), Colors.red);
            });
            }, icon: Icon(Icons.logout,color: Colors.black,)),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Searrch',
                border: OutlineInputBorder()
              ),
              onChanged: (value) {
                setState(() {

                });
              },
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder: (context,snapshot,animation,index){

                  final title=snapshot.child('title').value.toString();
                  
                  if(searchFilter.text.isEmpty){
                    return  ListTile(
                      title: Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(snapshot.child('id').value.toString(),style: TextStyle(color: Colors.black),),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                        PopupMenuItem(value: 1,child: ListTile(onTap:() {
                          Navigator.pop(context);
                          showMyDialog(title,snapshot.child('id').value.toString());
                        },leading: Icon(Icons.edit),title: Text('Edit'),)),
                        PopupMenuItem(value: 2,child: ListTile(
                          onTap: (){
                            ref.child(snapshot.child('id').value.toString()).remove();
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.delete,color: Colors.red,),title: Text('Delete'),)),
                      ],)
                    );
                  }else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toString())){
                    return  ListTile(
                      title: Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(snapshot.child('id').value.toString(),style: TextStyle(color: Colors.black),),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                        PopupMenuItem(value: 1,child: ListTile(onTap:() {
                          Navigator.pop(context);
                          showMyDialog(title,snapshot.child('id').value.toString());
                        },leading: Icon(Icons.edit),title: Text('Edit'),)),
                        PopupMenuItem(value: 2,child: ListTile(
                          onTap: (){
                            ref.child(snapshot.child('id').value.toString()).remove();
                            Navigator.pop(context);
                          },leading: Icon(Icons.delete,color: Colors.red,),title: Text('Delete'),)),
                      ],)
                    );
                  }else{
                    return Container();
                  }

                }),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddPosts(),));
      },child: Icon(Icons.add),),
    );
  }
  Future<void> showMyDialog(String title,String id)async{
    updateController.text=title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: updateController,
              decoration: InputDecoration(
                hintText: 'Enter text here'
              ),),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  'title':updateController.text.toLowerCase()
                }).then((value){
                  Utils.toastMessage('Updated Successfully', Colors.green);
                }).onError((error,stackTrace){
                  Utils.toastMessage(error.toString(), Colors.red);
                });
              }, child: Text('Update')),
            ],
          );
        });
  }
}
