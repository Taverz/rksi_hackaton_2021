import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/calendar_page.dart';
import 'package:flutter_app/chat/chat_page.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/event.dart';
import 'package:uuid/uuid.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    _profileInfo(String name) {
      return Container(
        height: 300,
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
              Container(
                  margin: EdgeInsets.only(top: 85, bottom: 10),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/Profile_logo.png'),
                    ),
                  )),
              Text(
                name,
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
                Container(
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
                                    image:
                                        AssetImage('assets/images/Message.png'),
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
                Container(
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
                      ),
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
                String name = "Курбатова Анастасия";

            if( profileDataCurrent!= null){
              print(profileDataCurrent!.name);
                name = profileDataCurrent!.name;
            }
            return _profileInfo(name);
          }
        ), _contentInfo()],
      ),
    ));
  }
}



List<QueryDocumentSnapshot<Map<String, dynamic>>>? calendare ;
List<ProfileData>? allData_calendare;

ProfileData? profileDataCurrent;

Future<ProfileData?> getUsersData({required String login , required String password}) async {
   var querySnapshot = await fire.collection('users').doc(login).get();

   Map? maps = querySnapshot.data();
   if(maps != null){
     profileDataCurrent = ProfileData.fromMap(maps);
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

setUser(ProfileData data)async {
 

  // var uuid = Uuid();
  // String random = uuid.v1();
 await fire.collection('users').doc(data.email).set(data.toMap()); // update({"update":data.toMap()});
}

class ProfileData {
  String name;
  String email;
  String descritption;

  ProfileData({
    required this.name,
    required this.email,
    required this.descritption,
  });

   Map<String, dynamic> toMap(){
     return {
      "name":name,
      // "to":modifiedReleaseDate,
      // "allDay":allDay,
      // "froml":modifiedReleaseDate2,
      "email":email,
      "descritption":name,
      // "description":description,
    };
   }

    factory ProfileData.fromMap(Map map){
    return ProfileData(
      name: map["name"] ,
      email: map["email"] ,
      descritption: map["descritption"] ,
    );
    }

}