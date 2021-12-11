import 'package:flutter/widgets.dart';
import 'package:rksi_hackaton_2021/model/basket_item.dart';

///Корзина товаров
class Basket extends ChangeNotifier {
  ///Количество содержимого
  int countItem = 0;

  ///Список содержимого
  List<BasketItem> itemsBasket = [
    BasketItem(
        name: "Stul1",
        price: 25.5,
        description: "Обычный стул",
        imageUrl:
            "https://avatars.mds.yandex.net/get-mpic/4289990/img_id4505815381297457684.jpeg/orig"),
    BasketItem(
        name: "Stul2",
        price: 30,
        description: "Хуета какая-та",
        imageUrl:
            "https://avatars.mds.yandex.net/get-mpic/3916156/img_id1578111255684523668.jpeg/orig"),
    BasketItem(
        name: "Stul3",
        price: 25.5,
        description: "Третий стул",
        imageUrl:
            "https://avatars.mds.yandex.net/get-mpic/4585707/img_id6179979996928432799.jpeg/orig"),
    BasketItem(
        name: "Stul1",
        price: 25.5,
        imageUrl:
            "https://avatars.mds.yandex.net/get-marketpic/5607353/pic31e6d7b60c07b3cb70921b01e65077a4/orig"),
    BasketItem(
        name: "Stul1",
        price: 25.5,
        imageUrl:
            "https://avatars.mds.yandex.net/get-marketpic/5607353/pic31e6d7b60c07b3cb70921b01e65077a4/orig"),
  ];

  addItemBasket(BasketItem item) {
    countItem++;
    itemsBasket.add(item);
    notifyListeners();
  }

  removeItemBasket(BasketItem item) {
    countItem--;
    itemsBasket.removeWhere((element) => element == item);
    notifyListeners();
  }

  List<BasketItem> getAllItemsBasket() {
    return itemsBasket;
  }
}
