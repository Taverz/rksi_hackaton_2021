

import 'package:flutter/widgets.dart';
import 'package:rksi_hackaton_2021/model/basket_item.dart';

///Корзина товаров
class Basket extends ChangeNotifier{

  ///Количество содержимого
  int countItem = 0;
  ///Список содержимого
  List<BasketItem> itemsBasket = [];

  addItemBasket(BasketItem item){
    countItem++;
    itemsBasket.add(item);
     notifyListeners();
  }

  removeItemBasket(BasketItem item){
    countItem--;
    itemsBasket.removeWhere((element) => element == item);
     notifyListeners();
  }

  List<BasketItem> getAllItemsBasket(){
    return itemsBasket;
  }
}