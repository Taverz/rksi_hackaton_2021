import 'package:flutter_app/calendar_page.dart';
import 'package:uuid/uuid.dart';

import 'provider/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'model/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'utils.dart';
import 'package:provider/provider.dart';

class CreateEventPage extends StatefulWidget {
  final Event? event;
  const CreateEventPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController =
      TextEditingController(); //Для управления текстовым полем
  late DateTime from; // со скольки начинается событие
  late DateTime to; //конец события

  @override
  void initState() {
    // Создание функции обозначающая конец и начало
    super.initState();

    if (widget.event == null) {
      from = DateTime.now();
      to = DateTime.now().add(Duration(hours: 3));
    }
  }

  void desponse() {
    titleController.dispose();
    super.dispose();
  }

  List<Widget> saving() => [
        //Кнопка сохранения
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: () {
              saveForm();
            },
            icon: Icon(Icons.done),
            label: Text("Сохранить"))
      ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 232, 248, 1),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: CloseButton(), //Кнопка закрытия
        actions: saving(), //вызов виджета сохранения
      ),
      body: SingleChildScrollView(
        key: _formKey,
        child: Column(
          children: <Widget>[
            createTitle(),
            SizedBox(
              height: 10,
            ),
            createDateTime(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  createTitle() => TextFormField(
        //Добавление заголовка
        decoration: InputDecoration(hintText: 'Добавить запись'),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) {
          title != null && title.isEmpty
              ? print('Запись не может быть пустой')
              : null;
        }, //Если закоговок пустой, то появится надпись
        controller: titleController,
      );

  createDateTime() => Column(
        //Виджет выбора даты и времени события
        children: [createFrom(), createto()],
      );
  createFrom() => Row(
        //виджет начала события
        children: [
          Expanded(
              flex: 2,
              child: createField(
                text: Utils.toDate(from),
                onClicked: () {
                  takeFromDate(pickDate: true);
                },
              )),
          Expanded(
              child: createField(
                  text: Utils.toDateTime(from),
                  onClicked: () {
                    takeFromDate(pickDate: false);
                  }))
        ],
      );
  createto() => Row(
        //виджет конца события
        children: [
          Expanded(
              flex: 2,
              child: createField(
                text: Utils.toDate(to),
                onClicked: () {
                  takeToDate(pickDate: true);
                },
              )),
          Expanded(
              child: createField(
                  text: Utils.toDateTime(to),
                  onClicked: () {
                    takeToDate(pickDate: false);
                  }))
        ],
      );
  Future takeFromDate({required bool pickDate}) async {
    final date = await takeDate(from, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(to)) {
      to = DateTime(date.year, date.month, date.day, to.hour, to.minute);
    }
    setState(() => from = date);
  }

  Future takeToDate({required bool pickDate}) async {
    final date = await takeDate(to,
        pickDate: pickDate,
        firstDate: pickDate ? from : null); // запрет выбора даыт раньше начала
    if (date == null) return;
    setState(() => to = date);
  }

  Future<DateTime?> takeDate(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      //Если выбрали изменение даты
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  createField({
    //виджет рисующий начало и конец
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
  Future saveForm() async {
    bool allday = true;
    // await updateCalendare(Event(
    //   description:  titleController.text.toString(),
    //   name: titleController.text.toString() ,
    //   froml:from , to: to,
    //   allDay: allday
    // ));
    var uuid = Uuid();
    String random = uuid.v1();
    final event = Event(
        id: random,
        description: titleController.text.toString(),
        name: titleController.text.toString(),
        froml: from,
        to: to,
        allDay: allday);
    final provider = Provider.of<EventProvider>(context, listen: false);

    await provider.addEvent(event);
    Navigator.of(context).pop();
  }
}
