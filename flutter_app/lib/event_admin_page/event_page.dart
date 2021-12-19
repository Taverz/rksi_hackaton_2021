import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_app/chat/group_chat.dart';
import 'package:flutter_app/main.dart';

final FirebaseFirestore _fire = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class EventPage extends StatefulWidget {
  // final String groupName;
  // final String groupId;
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Мероприятия"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_outlined),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                      actions: [
                        FloatingActionButton(
                            child: Icon(Icons.add_outlined),
                            backgroundColor: Colors.purple,
                            onPressed: () async {
                              await createEvent(controllerName.text,
                                  controllerDescription.text);
                            })
                      ],
                      content: Container(
                        height: 200,
                        child: Column(children: [
                          TextField(
                              controller: controllerName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Название мероприятия',
                                  labelStyle: TextStyle(color: Colors.white))),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                              controller: controllerDescription,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Описание мероприятия',
                                  labelStyle: TextStyle(color: Colors.white))),
                        ]),
                      ),
                      title: Text(
                        "Заполните данные мероприятия",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.purple[400]),
                );
              },
            )
          ],
        ),
        body: Container(
            child: FutureBuilder(
                future: listEvents(),
                builder: (context, assync) {
                  List<EventsW> listW = [];
                  if (assync.hasData && assync.data != null) {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> listMap =
                        assync.data as List<
                            QueryDocumentSnapshot<Map<String, dynamic>>>;
                    listMap.forEach((element) {
                      listW.add(EventsW.fromMap(element.data()));
                    });
                  }
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: listW.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Row(children: [
                          SingleChildScrollView(
                              child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(vertical: 15),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Text(listW[index].title +
                                "        " +
                                listW[index].content),
                          )
                              // Text(listW[index].title +
                              //     "|" +
                              //     listW[index].content))
                              // ])
                              )
                        ]));
                      });
                })));
  }

  Future createEvent(String title, String content) async {
    if (permission == "adm") {
      print("Create Events");
      String groupId = Uuid().v1();

      await _fire.collection('events').doc(groupId).set(
          {"title": title, "content": content, "description": "descritption"});

      String uid = groupId;

      //   await _fire
      //       .collection('groupchat')
      //       .doc(uid)
      //       .collection('chats')
      //       // .doc(groupId)
      //       .add({
      //   "message": "$uid createGroup!!",
      //   "type": "text",
      // });

      setState(() {});
    }

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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> listEvents() async {
    String _mm = _auth.currentUser!.uid;

    await _fire.collection('events').get().then((value) {
      listGroup = value.docs;
    });

    return listGroup;
  }
}

class EventsW {
  String title;
  String content;
  String descritption;

  EventsW({
    required this.title,
    required this.content,
    required this.descritption,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
      "description": descritption,
    };
  }

  factory EventsW.fromMap(Map map) {
    return EventsW(
      title: map["title"].toString(),
      content: map["content"].toString(),
      descritption: map["descritption"].toString(),
    );
  }
}
