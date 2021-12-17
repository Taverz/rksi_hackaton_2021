import 'package:flutter/material.dart';

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
            color: Colors.purple,
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
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
              ),
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
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30, top: 30, left: 15, right: 15),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(45))),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(45))),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(45))),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 100,
                  width: 50,
                  //   decoration:
                  //       BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  // ),
                  // Container(
                  //   child: Text("Календарь"),
                )
              ],
            ),
          )
        ],
      ));
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[_profileInfo("Курбатова Анастасия"), _contentInfo()],
      ),
    ));
  }
}
