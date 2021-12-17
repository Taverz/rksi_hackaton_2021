import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    _name() {
      return const Padding(
        padding: EdgeInsets.only(top: 150),
        child: Align(
            child: Text(
          "Добро пожаловать!",
          style: TextStyle(fontSize: 40),
        )),
      );
    }

    _inputText(String hint, TextEditingController controller, bool hide) {
      return Container(
        child: TextField(
            controller: controller,
            obscureText: hide,
            decoration: InputDecoration(hintText: hint)),
      );
    }

    _content() {
      return Container(
          height: 300,
          padding: EdgeInsets.only(top: 150),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  height: 100,
                  child: Column(children: <Widget>[
                    Container(
                      //Окно Логина
                      margin: EdgeInsets.only(right: 100),
                      child: _inputText("EMAIL", _emailController, false),
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                          )),
                    ),
                    Container(
                      //Окно Пароля
                      child: _inputText("Password", _passwordController, true),
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(80))),
                      margin: EdgeInsets.only(right: 100),
                    ),
                  ]),
                ),
              ),
              Positioned(
                top: 20,
                right: 75,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    color: Colors.blue,
                  ),
                  height: 60,
                  width: 60,
                ),
              )
            ],
          ));
    }

    return Scaffold(
        backgroundColor: Colors.purple,
        body: Column(
          children: <Widget>[_name(), _content()],
        ));
  }
}
