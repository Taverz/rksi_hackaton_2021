import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/event.dart';
import 'package:flutter_app/provider/event_provider.dart';
import 'package:flutter_app/widget/Taskwidget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
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
Future getCAlendare() async {
 await fire.collection('df5239jdsf3').
   get().then((value ){
    calendare = value.docs ;
  });

  var tt = calendare![0].data();
  Map<String, dynamic> mapp = tt["update"];
  Event.fromMap(mapp);
}

// deleteCalendare()async {
//  await fire.collection('df5239jdsf3').doc("calen").delete();
// }

updateCalendare(Event data)async {
 await fire.collection('df5239jdsf3').doc("calen").update({"update":data.toMap()});
}

