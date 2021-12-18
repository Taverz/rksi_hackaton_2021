

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/chat/chat_page.dart';


//   final FirebaseFirestore _fire = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> listGroup = [];

// Future listGroupChat() async {
//   String _mm = _auth.currentUser!.uid;

//   await _fire.collection('user').doc(_mm)
//   .collection("groups").get().then((value ){
//     listGroup = value.docs;
//   });

// }

// chooiseChate(BuildContext context, int index){
//   Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (_) => ChatPage(
//             groupName: listGroup[index]['name'],
//             groupId: listGroup[index]['id'],
//           ),
//         ),
//       );
// }


// title: Text(groupList[index]['name']),