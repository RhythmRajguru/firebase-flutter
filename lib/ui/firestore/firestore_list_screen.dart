import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_flutter/ui/auth/login_screen.dart';
import 'package:firebase_flutter/ui/firestore/add_firestore_data.dart';
import 'package:firebase_flutter/ui/posts/add_posts.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {


  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final auth=FirebaseAuth.instance;
  final searchFilter=TextEditingController();
  final updateController=TextEditingController();
  final firestore=FirebaseFirestore.instance.collection('Users').snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Firestore')),
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
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                if(snapshot.hasError){
                  return Text('Some Error');
                }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return  ListTile(
                            subtitle: Text(snapshot.data!.docs[index].id.toString()),
                            title: Text(snapshot.data!.docs[index]['title'].toString()),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(value: 1,child: ListTile(onTap:() {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        var title=snapshot.data!.docs[index]['title'].toString();
                                        updateController.text=title;
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
                                              ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                                                'title':updateController.text,
                                              }).then((value){
                                                Utils.toastMessage('Updated Successfuly', Colors.green);
                                              }).onError((error,stackTrace){
                                                Utils.toastMessage(error.toString(), Colors.red);
                                              });
                                            }, child: Text('Update')),
                                          ],
                                        );
                                      });

                                },leading: Icon(Icons.edit),title: Text('Edit'),)),
                                PopupMenuItem(value: 2,child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    ref.doc(snapshot.data!.docs[index]['id'].toString()).delete().then((value){
                                      Utils.toastMessage('Deleted Successfuly', Colors.green);
                                    }).onError((error,stackTrace){
                                      Utils.toastMessage(error.toString(), Colors.red);
                                    });
                                  },leading: Icon(Icons.delete,color: Colors.red,),title: Text('Delete'),)),
                              ],)
                          );
                    
                      },),
                  );
              },),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddFirestoreData(),));
      },child: Icon(Icons.add),),
    );
  }

}
