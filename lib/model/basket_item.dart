

class BasketItem {
  BasketItem({
    required this.name,
    required this.price,
    this.description
  });
  ///Название товара
  String name;
  ///Цена товара
  double price;
  ///Описание
  String? description;
  
}