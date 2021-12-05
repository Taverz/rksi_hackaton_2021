import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rksi_hackaton_2021/pages/home/home_page.dart';
import 'package:rksi_hackaton_2021/provider/basket.dart';

import 'package:rksi_hackaton_2021/provider/database_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider( //sdfsdf sad asdsf
        providers: [
          //Provider с изменением состояния
          ChangeNotifierProvider(create: (context)=>DataBase()),
          ChangeNotifierProvider(create: (context)=>Basket()),
        ],
        child: const HomePage(),
      )
    );
  }
}


