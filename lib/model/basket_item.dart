class BasketItem {
  BasketItem(
      {required this.name,
      required this.price,
      this.description,
      this.imageUrl});

  ///Название товара
  String name;

  ///Цена товара
  double price;

  ///Описание
  String? description;
  //Картинка
  String? imageUrl;
}
