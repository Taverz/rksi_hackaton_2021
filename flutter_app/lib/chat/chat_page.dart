import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  // final String groupName;
  // final String groupId;
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: 'Jov089AdBjVugMSvmT0VbPs07sB');

  void _addMessage(types.Message message) async{
     var uuid = Uuid();
      String random = uuid.v1();
    await fire.collection('сhatall').doc(random).set({"params":message.toJson()}); // update({"update":data.toMap()});

    _loadMessages();
    // setState(() {
    //   _messages.insert(0, message);
    // });
  }

  void _loadMessages() async {
     QuerySnapshot querySnapshot = await fire.collection('сhatall').
   get()
   ;
  //  List<Event> 
  //  allData
  var tte =querySnapshot.docs;
   var allChatDate = 
   querySnapshot.docs.map((doc ) {
    var trr = doc.data();
    print("DOC"+doc["params"].toString());
     print("DOC"+doc.toString());
    return types.Message.fromJson(doc["params"] ) ;   // .fromMap(doc["update"] as Map);
   }).toList();

    // final response = await rootBundle.loadString('assets/messages.json');
    // final messages = (jsonDecode(response) as List)
    //     .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
    //     .toList();

    setState(() {
      _messages = allChatDate;
    });
  }


  @override
  void initState() {
     

    super.initState();
  }

  void _handleSendPressed(types.PartialText message) {
      var uuid = Uuid();
      String random = uuid.v1();
    final textMessage = types.TextMessage(
      id: random,
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Чат"),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        bottom: false,
        child: Chat(
          theme: const DefaultChatTheme( 
            inputBackgroundColor: Colors.green,
            receivedMessageDocumentIconColor: Colors.red,
            secondaryColor: Colors.indigo,
            primaryColor: Colors.purple
          ),
          messages: _messages,
          // onAttachmentPressed: _handleAtachmentPressed,
          // onMessageTap: _handleMessageTap,
          // onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      ),
      
    );
  }
}
