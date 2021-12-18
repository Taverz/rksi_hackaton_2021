import 'package:flutter/material.dart';
import 'package:flutter_app/calendar_page.dart';

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
        children: <Widget>[_profileInfo("Курбатова Анастасия"), _contentInfo()],
      ),
    ));
  }
}
