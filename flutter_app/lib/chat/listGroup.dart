// import 'dart:ffi';

// import 'dart:ffi';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/chat/group_chat.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class ListGroup extends StatefulWidget {
  // final String groupName;
  // final String groupId;
  const ListGroup({Key? key}) : super(key: key);

  @override
  _ListGroupState createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // getGroupChat();
    return Scaffold(
      appBar: AppBar(
        title: Text("Чаты"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_outlined),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    content: TextField(controller: controller),
                    actions: [
                      FloatingActionButton(
                          child: Icon(Icons.add_outlined),
                          backgroundColor: Colors.purple,
                          onPressed: () async {
                            await createChatGroup(controller.text);
                          })
                    ],
                    elevation: 24,
                    title: Text("Введите название чата"),
                    backgroundColor: Colors.deepPurple[400]),
              );
            },
          )
        ],
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
          future: listGroupChat(),
          builder: (context, async) {
            List<dynamic> groupListWW = [];
            if (async.data != null && async.hasData) {
              groupListWW = async.data as List<dynamic>;
              print("NAME GROUP " + groupListWW.length.toString());
              print("OOOO "+groupListWW[0]["id"].toString());


              //  print("NAME GROUP "+groupListWW[0]["name"]);

            }

            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: groupListWW.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => GroupChat(
                                      groupChatId: groupListWW[index]["id"],
                                      groupName: groupListWW[index]["name"],
                                    )));
                      },
                      child: _itemGroupList(title:groupListWW.length > 0 ?
                       groupListWW[index] ["name"] : "" ));
                  // return _itemGroupList(title: groupListWW[index]["name"]);
                  // return Container(child: Text(groupListWW[index]["name"]),);
                });
          }),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add_outlined),
      //   backgroundColor: Colors.purple,
      //   onPressed: () async {
      //     await createChatGroup();
      //   },
      //   tooltip: "Create Group",
      //   // Navigator.of(context)
      //   //       .push(MaterialPageRoute(builder: (context) => CreateEventPage())
      // ),
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

  Future createChatGroup(String title) async {
    String groupId = Uuid().v1();
    String groupName = title;

    await _fire.collection('groupchat').doc(groupId).set({
      "name": groupName,
      "id": groupId,
    });

    String uid = groupId;

    await _fire.collection('groupchat').doc(uid).collection('chats')
        // .doc(groupId)
        .add({
      "message": "$uid createGroup!!",
      "type": "text",
    });

    setState(() {});

    //     .set({
    //   "name":"Name_$groupId",
    //   "id": groupId,
    // });

    // await _fire.collection('groupchat').doc(groupId).collection('chats').add({
    //   "message": "${_auth.currentUser!.displayName} createGroup!!",
    //   "type": "text",
    // });
  }

  final FirebaseFirestore _fire = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List listGroup = [];

  Future<List>
      listGroupChat() async {
    String _mm = _auth.currentUser!.uid;
  List<String> listUserChat = groupListt!.split(",");
    await _fire.collection('groupchat').get().then((value) {
      value.docs.forEach((element) {
        if(listUserChat.contains(element.id)){
           listGroup.add(element);
        }
      });
     
    });

     
    //  listUserChat.forEach((element) async{
    //   listGroup = await _fire
    //       .collection('groupchat')
    //       .doc(element.toString())
         
    //       .collection('chats')
    //       .snapshots().toList();
    //       print(listGroup.length);
          // .get()
          // .then((value) {
          //     print("DDDDDMM " +value.toString());
          //     print("DDDDDMM " +value.docs.toString());
          //     // setState(() {
          //     listGroup = value.docs;
          //     // });
          //   });
      // });

      // setState(() {
        
      // });

    return listGroup;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> groupList = [];

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getGroupChat() async {
    String uid = _auth.currentUser!.uid;

    List<String> listUserChat = groupListt!.split(",");
    listUserChat.forEach((element) async{
      await _fire
          .collection('groupchat')
          .doc(element)
          .collection('chats')
          .get()
          .then((value) {
              print("DDDDDMM");
              // setState(() {
              groupList = value.docs;
              // });
            });
      });
    

    // await fire.collection('groupchat').doc().get().then((value2) async {
    //   print("WWWW");
    //   print(value2.id);

    //   await _fire
    //       .collection('groupchat')
    //       .doc(value2.id)
    //       .collection('chats')
    //       .get()
    //       .then((value) {
    //     print("DDDDD");
    //     // setState(() {
    //     groupList = value.docs;
    //     // });
    //   });
    // });

    // _fire
    //             .collection('groupchat')
    //             .doc(groupChatId)
    //             .collection('chats')

    return groupList;
  }
}
