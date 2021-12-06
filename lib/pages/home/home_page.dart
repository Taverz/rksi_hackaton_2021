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
        name: "NMAE", price: 200.30, description: "desctiprion simple"));
    //int count = provBasket.countItem;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: (MediaQuery.of(context).size.width < 800)
                    ? //Если ширина страницы меньше 800 то вывести это, если нет то
                    ListView.builder(
                        itemCount: provBasket.itemsBasket.length,
                        itemBuilder: (context, index) {
                          return _itemList(index);
                        })
                    : //
                    GridView.builder(
                        //то вывести это
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, //паралельно 3
                                crossAxisSpacing:
                                    16, //расстояние между ними по горизонтали
                                mainAxisSpacing:
                                    16 //расстояние между ними по вертикали
                                ),
                        itemBuilder: (context, index) {
                          return _itemList(index);
                        }))
          ],
        ),
      ),
    );
  }

  Widget _itemList(int index) {
    //Чтобы по 50 раз одно и тоже не писать мы выносим его в отдельный метод, где возврашаем наш виджет
    return Container(
      child: Text("Item $index"),
    );
  }
}
