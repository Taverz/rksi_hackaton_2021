import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rksi_hackaton_2021/model/basket_item.dart';
import 'package:rksi_hackaton_2021/provider/basket.dart';

///Главная страница
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //синий обозначает что он нигде не используется
    Basket provBasket = Provider.of<Basket>(context);
    provBasket.addItemBasket(BasketItem(
        name: "NMAE", 
        price: 200.30, 
        description: "desctiprion simple"
        ));
    // int  count =  provBasket.countItem; 
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
