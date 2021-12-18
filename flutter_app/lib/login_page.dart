import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bi/auth.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/profile_page.dart';

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
    // _welcome(String text) {
    //   //надпись "добро пожаловать" и блок сверху
    //   return Container(
    //     height: 300,
    //     child: Stack(children: [
    //       Positioned(
    //         bottom: 50,
    //         left: 0,
    //         right: 0,
    //         child: Container(
    //             //Добавление кругов
    //             width: MediaQuery.of(context).size.width,
    //             decoration: BoxDecoration(
    //               color: Color.fromRGBO(92, 208, 97, 0.8),
    //               shape: BoxShape.circle,
    //             ),
    //             child: Column(children: [
    //               //круг в круге
    //               Container(
    //                   decoration: BoxDecoration(
    //                       color: Color.fromRGBO(71, 238, 68, 0.8),
    //                       shape: BoxShape.circle),
    //                   width: 350,
    //                   height: 400,
    //                   //Добавление текста
    //                   child: Align(
    //                     alignment: Alignment.center,
    //                     child: Text(
    //                       text,
    //                       style: TextStyle(color: Colors.black87, fontSize: 30),
    //                     ),
    //                   )),
    //             ])),
    //       )
    //     ]),
    //   );
    // }

    //Текст вводимый в поля логина и пароля
    _inputText(String hint, TextEditingController controller, bool hide) {
      return Container(
        padding: EdgeInsets.only(left: 15),
        child: TextField(
            controller: controller,
            obscureText: hide, //Скрывать ли символы
            decoration:
                InputDecoration(hintText: hint)), //Контент внутри контейнера
      );
    }

    _button(String text,) {
      //Виджет кнопки
      return ElevatedButton(
        onPressed: () async {
          print("RET");
          bool auth = await LoginFire(FirebaseAuth.instance).signIn(
              email: _emailController.text, password: _passwordController.text);
          if (auth) {
            print("AUTH ");
            emaiil = _emailController.text;
            password =  _passwordController.text;
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => profilePage()));
          } else {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    elevation: 24,
                    title: Text("Неверный логин или пароль"),
                    backgroundColor: Colors.purple));
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80));
        })),

        child: Text(text), //Что находится кнутри кнопки
      );
    }

    //Авторизация
    _content(void func()) {
      return Container(
          //Общий контейнер
          height: 300,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  height: 200,
                  child: Column(children: <Widget>[
                    Container(
                      //Окно Логина
                      margin: EdgeInsets.only(right: 50),
                      child: _inputText("Логин", _emailController,
                          false), //вызов виджета в котором прописываются параметры внутренности
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                          )),
                    ),
                    Container(
                      //Окно Пароля
                      child: _inputText("Пароль", _passwordController,
                          true), //вызов виджета в котором прописываются параметры внутренности
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(80))),
                      margin: EdgeInsets.only(right: 50),
                    ),
                  ]),
                ),
              ),
              Positioned(
                  //кнопка авторизации
                  top: 20,
                  right: 25,
                  child: GestureDetector(
                    // onTap: ()async {
                    //   print("RET");
                    //   bool auth = await LoginFire(FirebaseAuth.instance).signIn(email: _emailController, password: _passwordController);
                    // if(auth){
                    //   print("AUTH ");
                    //   // Navigator.push(context, MaterialPageRoute(builder: (_)=> profilePage()
                    //   //   )
                    //   // );
                    // }else{
                    //   print("Error AUTH ");
                    // }
                    // },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: _button("", ), //Вызов виджета кнопки
                      height: 60,
                      width: 60,
                    ),
                  )),
            ],
          ));
    }

    _logo(String text) {
      return Container(
          child: Stack(children: [
        Positioned(
          top: 30,
          left: 105,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        Positioned(
            child: Image.asset(
          'assets/images/emblem.png',
          width: 255,
          height: 150,
        ))
      ]));
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Background.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            SizedBox(height: 360),
            _content(() {}),
            _logo("KFK")
          ],
        ),
      ),
    ));
  }
}
