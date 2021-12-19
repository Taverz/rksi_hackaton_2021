import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/calendar_page.dart';
import 'package:flutter_app/chat/chat_page.dart';
import 'package:flutter_app/chat/listGroup.dart';
import 'package:flutter_app/event_admin_page/event_page.dart';
import 'package:flutter_app/image_chooise/profile_avatar_image/image_demo_editor.dart';
import 'package:flutter_app/image_chooise/profile_avatar_image/pgoto_coise.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/event.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    _profileInfo(String name, String uchZav, String uchitel) {
      return Container(
        height: 360,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Background_profile_up.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80))),
        child: Align(
          child: Column(
            children: [
              FutureBuilder(
                  future: ImageSaver.getImage(),
                  builder: (context, async) {
                    if (async.hasData &&
                        async.data != "" &&
                        async.data != null) {
                      var img =
                          Image(image: FileImage(File(async.data!.toString())));
                      return GestureDetector(
                        onTap: () {
                          print("object pat");
                          showMySheet(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 85, bottom: 10),
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                image: img.image,
                              ),
                            )),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        print("object pat");
                        showMySheet(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 85, bottom: 10),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Profile_logo.png'),
                            ),
                          )),
                    );
                  }),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 15,),
              Text(
                ""+ uchZav,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 15,),
              Text(
                "Куратор- "+ uchitel,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      );
    }

    _contentInfo() {
      return SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/Background_profile_bottom.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ListGroup())),
                  child: Container(
                      child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        margin: EdgeInsets.only(
                            left: 40, right: 20, top: 20, bottom: 20),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(254, 245, 245, 1),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          children: [
                            Text("Сообщения"),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Message.png'),
                                      fit: BoxFit.fill)),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CalendarWidget())),
                          child: Container(
                            height: 150,
                            width: 150,
                            padding: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(254, 245, 245, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                border: Border.all(color: Colors.black)),
                            child: Column(children: [
                              Text("Календарь"),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/Calendar.png'),
                                        fit: BoxFit.fill)),
                              )
                            ]),
                          ))
                    ],
                  )),
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => EventPage())),
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            margin: EdgeInsets.only(
                                left: 40, right: 20, top: 20, bottom: 20),
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(254, 245, 245, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              children: [
                                Text("Мероприятия"),
                                Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Events.png'),
                                            fit: BoxFit.fill))),
                              ],
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(254, 245, 245, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            children: [
                              Text("Помощь"),
                              Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/Help.png'),
                                          fit: BoxFit.fill))),
                            ],
                          )),
                    ],
                  ),
                ),
              ])));
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder(
              future: getUsersData(
                  login: emaiil ?? "admin", password: password ?? "123"),
              builder: (context, async) {
                String name = "Имя";

                if (profileDataCurrent != null) {
                  print(profileDataCurrent!.name);
                  nameUser = profileDataCurrent!.name;
                  name = nameUser!;
                  permission = profileDataCurrent!.permisiion;
                }
                return _profileInfo(name, profileDataCurrent!.indent, profileDataCurrent!.tech);
              }),
          _contentInfo()
        ],
      ),
    ));
  }
}

showMySheet(BuildContext context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      context: context,
      builder: (context) => PhotoChoise());
}

List<QueryDocumentSnapshot<Map<String, dynamic>>>? calendare;
List<ProfileData>? allData_calendare;

ProfileData? profileDataCurrent;

Future<ProfileData?> getUsersData(
    {required String login, required String password}) async {
  var querySnapshot = await fire.collection('users').doc(login).get();

  Map? maps = querySnapshot.data();
  if (maps != null) {
    profileDataCurrent = ProfileData.fromMap(maps);
    permission = profileDataCurrent!.permisiion;
    nameUser = profileDataCurrent!.name;
    groupListt = profileDataCurrent!.groupList;
    print(profileDataCurrent!.email);
  }

  //  profileDataCurrent = profileData;
  //  get()
  //  ;

  //  List<Event>
  //  allData
  // var tte =querySnapshot.docs;
  //  allData_calendare = querySnapshot.docs()

  //  .map((doc ) {
  //   //var trr = doc.data();
  //   //print("DOC"+doc["update"].toString());
  //   return ProfileData.fromMap(doc as Map);
  //  }).toList();

  //  .then((value ){
  //   calendare = value.docs.toList() ;
  // });

  // var allData = calendare![0]!.docs().map((doc) => doc.data()).toList();
  //   List allDaata = calendare.;
  //  calendare = calendare;

  // if(calendare != null)
  // Event.fromMap(calendare);
  return profileDataCurrent;
}

// deleteCalendare()async {
//  await fire.collection('df5239jdsf3').doc("calen").delete();
// }

setUser(ProfileData data) async {
  // var uuid = Uuid();
  // String random = uuid.v1();
  await fire
      .collection('users')
      .doc(data.email)
      .set(data.toMap()); // update({"update":data.toMap()});
}

class ProfileData {
  String name;
  String email;
  String descritption;
  String permisiion;
  String groupList;
  String indent;
  String classW;
  String tech;

  ProfileData({
    required this.name,
    required this.email,
    required this.descritption,
    required this.permisiion,
    required this.groupList,
    required this.indent,
    required this.classW,
    required this.tech
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      // "to":modifiedReleaseDate,
      // "allDay":allDay,
      // "froml":modifiedReleaseDate2,
      "email": email,
      "descritption": name,
      "permission": permisiion,
      "groupList": groupList,
      "indent":indent,
      "classW":classW,
      "tech":tech
      // "description":description,
    };
  }

  factory ProfileData.fromMap(Map map) {
    return ProfileData(
      name: map["name"].toString(),
      email: map["email"].toString(),
      descritption: map["descritption"].toString(),
      permisiion: map["permission"].toString(),
      groupList: map["groupList"].toString(),
      indent : map["indent"].toString(),
      classW: map["classW"].toString(),
      tech: map["tech"].toString()
    );
  }
}
