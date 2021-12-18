import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ProfilePage.dart';
import 'package:flutter_app/bi/auth.dart';

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
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.green[200],
            shape: BoxShape.circle,
          ),
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.green[100], shape: BoxShape.circle),
              height: 100,
            ),
          ]));
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
                child: GestureDetector(
                  onTap: () async {
                    bool auth = await LoginFire(FirebaseAuth.instance).signIn(email: _emailController, password: _passwordController);
                    if(auth){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> profilePage()
                        )
                      );
                    }else{
                      print("Error AUTH ");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      color: Colors.blue,
                    ),
                    height: 60,
                    width: 60,
                  ),
                ),
              )
            ],
          ));
    }

    _logo(String text) {
      return Container(
        child: Text(
          text,
          style: TextStyle(fontSize: 30),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.purple,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _name(),
              SizedBox(height: 50),
              _content(),
              _logo("KFK")
            ],
          ),
        ));
  }
}
