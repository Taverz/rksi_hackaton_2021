// import 'dart:html';

// import 'package:flutter_app/provider/event_provider.dart';
// import 'package:flutter_app/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ViewEvent extends StatefulWidget {
//   final Event event;
  
//   const ViewEvent({Key? key, required this.event}) : super(key: key);
//   @override
//   _ViewEventState createState() => _ViewEventState();
//   Widget build(BuildContext context) => Scaffold(
    
//         appBar: AppBar(
//           leading: CloseButton(),
//           // actions: buildViewingActions(context, event),
//         ),
//         body: ListView(
//           padding: EdgeInsets.all(32),
//           children: <Widget>[
//             buildDateTime(event),
//             Text(event.name),
//             const SizedBox(
//               height: 12,
//             ),
//             Text(event.description)
//           ],
//         ),
//       );
// }

// Widget buildDateTime(Event event) {
//   return Column(
//     children: [buildDate('To', event.to)],
//   );
// }

// class _ViewEventState extends State<ViewEvent> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<EventProvider>(context);
//     return Container();
//   }
// }
