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
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          decoration: BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage('assets/images/Background_profile_bottom.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                  child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: 40, right: 20, top: 20, bottom: 20),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(40)))),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  )
                ],
              )),
              Container(
                  child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 40, right: 20, top: 20, bottom: 20),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  ),
                  Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(40))))
                ],
              )),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[_profileInfo("Курбатова Анастасия"), _contentInfo()],
      ),
    ));
  }
}
