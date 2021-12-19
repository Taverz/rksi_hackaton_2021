
// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/chat/group_chat.dart';
import 'package:flutter_app/main.dart';
import 'package:uuid/uuid.dart';
final FirebaseFirestore _fire = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
class ListGroup extends StatefulWidget {
  // final String groupName;
  // final String groupId;
  const ListGroup({Key? key}) : super(key: key);

  @override
  _ListGroupState createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {

  @override
  Widget build(BuildContext context) {
    // getGroupChat();
    return Scaffold(
      appBar: AppBar(
        title: Text("Групповые чаты"),
      ),
        body: FutureBuilder(
            future: listGroupChat(),
          builder: (context, async) {
              List<QueryDocumentSnapshot<Map<String, dynamic>>> groupListWW = [];
            if(async.data != null && async.hasData){
             groupListWW =  async.data as List<QueryDocumentSnapshot<Map<String, dynamic>>> ;
             print("NAME GROUP "+groupListWW.length.toString());
            //  print("NAME GROUP "+groupListWW[0]["name"]);
             
            }
            
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: groupListWW.length,
              itemBuilder: (context , index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>
                      GroupChat(groupChatId:groupListWW[index]["id"] ,groupName: groupListWW[index]["name"],)
                    ));
                    
                  },
                  child: _itemGroupList(title: groupListWW[index]["name"])
                );
                // return _itemGroupList(title: groupListWW[index]["name"]);
                // return Container(child: Text(groupListWW[index]["name"]),);
              });
          }
        ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_outlined),
            backgroundColor: Colors.purple,
            onPressed: () async{
               await createChatGroup();
            },
            tooltip: "Create Group",
            // Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) => CreateEventPage())
                ),
       );
    
    
  }

  _itemGroupList({required String title}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        // onTap: (){
          
        // },
        child: Container(
          color: Colors.green,
          padding: EdgeInsets.all(15),
          child: Text(title),
        ),
      ),
    );
  }

  Future createChatGroup() async {
    String groupId = Uuid().v1();

    await _fire.collection('groupchat').doc(groupId).set({
      "name": "Name_$groupId",
      "id": groupId,
    });

    
      String uid = groupId;


      await _fire
          .collection('groupchat')
          .doc(uid)
          .collection('chats')
          // .doc(groupId)
          .add({
      "message": "$uid createGroup!!",
      "type": "text",
    });

    setState(() {
      
    });

      //     .set({
      //   "name":"Name_$groupId",
      //   "id": groupId,
      // });
    

    // await _fire.collection('groupchat').doc(groupId).collection('chats').add({
    //   "message": "${_auth.currentUser!.displayName} createGroup!!",
    //   "type": "text",
    // });
  }

  
  List<QueryDocumentSnapshot<Map<String, dynamic>>> listGroup = [];

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> listGroupChat() async {
  String _mm = _auth.currentUser!.uid;

  await _fire.collection('groupchat')
  .get().then((value){
    listGroup = value.docs;
  });
  
return listGroup;
}
List<QueryDocumentSnapshot<Map<String, dynamic>>> groupList = [];

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getGroupChat() async {
  String uid = _auth.currentUser!.uid;

 await fire
        .collection('groupchat').doc().get().then((value2) async{
          print("WWWW");
          print(value2.id);
                await _fire
              .collection('groupchat')
              .doc(value2.id)
              .collection('chats')
              .get()
              .then((value) {
                print("DDDDD");
                // setState(() {
                  groupList = value.docs;
                // });
              });
        }
        );


        // _fire
        //             .collection('groupchat')
        //             .doc(groupChatId)
        //             .collection('chats')

    
    return groupList;  

  }

}
