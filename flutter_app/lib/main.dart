import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/profile_page.dart';
import 'package:flutter_app/calendar_page.dart';
import 'package:flutter_app/provider/event_provider.dart';
import 'package:provider/provider.dart';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';


import 'package:firebase_core/firebase_core.dart';

 final FirebaseFirestore fire = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;  

  
void main() async{
  runApp(const MyApp());
  await getInitFireBaseAndPush();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}



Future getInitFireBaseAndPush() async {

  await Firebase.initializeApp();


    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new onMessage event was published! ${message.data}');
      newPushMessage(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published! ${message.data}');
      newPushMessage(message.data);
    });



    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(myBackgroundHandler);



}


newPushMessage(Map<String, dynamic> message) {
  print(message.toString());
  late String msgOSType = '';
  if (message.containsKey('data')) {


  }else {

  }


  switch (msgOSType) {
    case 'notify_type':
      {

      }
      break;
  }

}


Future<void> myBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');

}