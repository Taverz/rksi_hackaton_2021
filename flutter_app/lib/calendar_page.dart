import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/event.dart';
import 'package:flutter_app/provider/event_provider.dart';
import 'package:flutter_app/widget/Taskwidget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:uuid/uuid.dart';
import 'creating_event_page.dart';
import 'event_data_source.dart';
import 'package:provider/provider.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final envents = Provider.of<EventProvider>(context).events;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Календарь"),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: getCAlendare(),
        builder: (context, snapshot) {
          // List<Event> getData = [];
          // if(snapshot.hasData && snapshot.data != null){
          //     getData = allData_calendare!;
          //     // getData = snapshot.data as List<Event> ;
          //     envents.addAll(allData_calendare!);
          //      print("PPPPP "+allData_calendare!.length.toString());
          // }
          // print("PPPPP22 "+getData.length.toString());
          return Center(
            child: SfCalendar(
              todayHighlightColor: Colors.green,
              selectionDecoration:
                  BoxDecoration(border: Border.all(color: Colors.purple)),
              backgroundColor: Color.fromRGBO(245, 232, 248, 1),
              view: CalendarView.month,
              dataSource: EventDataSource(envents),
              initialSelectedDate: DateTime.now(),
              cellBorderColor: Colors.transparent,
              onLongPress: (details) {
                final provider = Provider.of<EventProvider>(context, listen: false);
                provider.setDate(details.date!);
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Tasks(),
                    backgroundColor: Colors.purple[100]);
              },
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_outlined),
        backgroundColor: Colors.purple,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateEventPage())),
      ),
    );
  }
}

List<QueryDocumentSnapshot<Map<String, dynamic>>>? calendare ;
List<Event>? allData_calendare;
Future<List<Event>?> getCAlendare() async {
   QuerySnapshot querySnapshot = await fire.collection('df5239jdsf3').
   get()
   ;
  //  List<Event> 
  //  allData
  var tte =querySnapshot.docs;
   allData_calendare = querySnapshot.docs.map((doc ) {
    //var trr = doc.data();
    //print("DOC"+doc["update"].toString());
    return Event.fromMap(doc["update"] as Map);
   }).toList();
  //  .then((value ){
  //   calendare = value.docs.toList() ;
  // });

  // var allData = calendare![0]!.docs().map((doc) => doc.data()).toList();
  //   List allDaata = calendare.;
  //  calendare = calendare;
  
  // if(calendare != null)
  // Event.fromMap(calendare);
  return allData_calendare;
}

// deleteCalendare()async {
//  await fire.collection('df5239jdsf3').doc("calen").delete();
// }

updateCalendare(Event data)async {
 

  var uuid = Uuid();
  String random = uuid.v1();
 await fire.collection('df5239jdsf3').doc(random).set({"update":data.toMap()}); // update({"update":data.toMap()});
}

