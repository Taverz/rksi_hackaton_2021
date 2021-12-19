
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/help/chat_pahe_help.dart';
import 'dart:math' as math;

import 'package:flutter_app/main.dart';
import 'package:uuid/uuid.dart';
class PageHelp extends StatefulWidget {
  const PageHelp({Key? key}) : super(key: key);

  @override
  _PageHelpState createState() => _PageHelpState();
}

class _PageHelpState extends State<PageHelp> {
  @override
  Widget build(BuildContext context) {
    

      // String _mm = _auth.currentUser!.uid;
      // createChat(nameUser.toString(),_mm );
      
          
          

    return Scaffold(
      body:
      permission == "adm" ?
       FutureBuilder(
         future: _getChatList(),
         builder: (context, async) {
           List<QueryDocumentSnapshot<Map<String, dynamic>>> ter  = [];
           if(async.hasData){
             ter = listChat;
           }
           return ListView.builder(
              itemCount:ter.length,
              itemBuilder: (context, index){
                return _itemGroupList(title:ter[index].data() != null? ter[index].data()["name"] ?? "" :"");
              }
            );
         }
       ):
        FutureBuilder(
          future: _futureGetOneChat(),
          builder: (context, async) {
            if(async.hasData){
              Map<String, dynamic>? date = async.data as Map<String, dynamic>?;
              return ChatHelp(groupChatId:date!["id"] , groupName:date["name"] ,);
            }
            return Container();
            
          }
        )
    );
  }
  _itemGroupList({required String title}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        // onTap: (){

        // },
        child: Container(
            height: 125,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(
              //   Radius.circular(80),
              // ),
              color: Colors.purple[100],
            ),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Text(title)),
                ),
              ],
            )),
      ),
    );
  }

  final FirebaseFirestore _fire = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> listChat = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future 
  < List<QueryDocumentSnapshot<Map<String, dynamic>>> >
  _getChatList()async {
     await _fire.collection('chatadmin').get().then((value) {
      listChat = value.docs;
     
    });

    return listChat;
  }

List<QueryDocumentSnapshot<Map<String, dynamic>>> userChat = [];
  Future<List>
      listGroupChat() async {
    String _mm = _auth.currentUser!.uid;
  // List<String> listUserChat = ;
    await _fire.collection('chatadmin').get().then((value)async {
      value.docs.forEach((element) async{
        if(_mm == element.id){
           await _fire
          .collection('chatadmin')
          .doc(_mm)
          .collection('chats')
          .get()
          .then((value) {
              print("DDDDDMMYY ");
              // setState(() {
              userChat = value.docs;
              // });
            });
        }
      });
     
    });
      
  return userChat;   
  }

  Future<Map<String, dynamic>?> 
  _futureGetOneChat() async {
      String _mm = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> 
    data = await _fire
          .collection('chatadmin')
          .doc(_mm).get();

    return data.data();
  }

  Future createChat(String userName, String uuid) async {
    String groupId =   uuid ; //Uuid().v1();
    // String groupName = userName;

    await _fire.collection('chatadmin').doc(groupId).set({
      "name": userName,
      "id": groupId,
    });

    // String uid = groupId;

    await _fire.collection('chatadmin').doc(groupId).collection('chats')
        // .doc(groupId)
        .add({
          "sendBy": nameUser, //logiin.currentUser!.displayName,
      
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      "message": "$userName create Admin!!",
     
    });


    // Map<String, dynamic> chatData = {
    //     "sendBy": nameUser, //logiin.currentUser!.displayName,
    //     "message": "_message.text",
    //     "type": "text",
    //     "time": FieldValue.serverTimestamp(),
    //   };
    //     _fire
    //       .collection('chatadmin')
    //       .doc(_mm)
    //       .collection('chats')
    //       .add(chatData);
  }

}