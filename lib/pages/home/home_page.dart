import 'dart:js';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rksi_hackaton_2021/model/basket_item.dart';
import 'package:rksi_hackaton_2021/provider/basket.dart';
import 'package:rksi_hackaton_2021/provider/provider.dart';
import 'package:rksi_hackaton_2021/pages/home/basket_page.dart';

///Главная страница
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  ///Для точек карусели изображений
  CarouselController _controller = CarouselController();

  ///Список виджетов для карусели изображений
  List<Widget> listItem = [];

  List<BasketItem> basketItem = [
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

  ///ДЛя того чтобы каррусель можно было переключать
  int _current = 0;

  List<String> listURL_image = [
    "https://mebelsofi.ru/upload/iblock/bb3/bb3a32bf63794d8ce9a9539d3a31b6ae.jpg",
    "https://mebelsofi.ru/upload/iblock/0d5/0d5b735a5b2b0529dba29a60bb95a8e2.jpg"
  ];

  BuildContext? contextW;
  late CarouselIndicator provCarousel;
  late Basket provBasket;

  @override
  Widget build(BuildContext context) {
    //синий обозначает что он нигде не используется
    provBasket = Provider.of<Basket>(context);
    provCarousel = Provider.of<CarouselIndicator>(context);

    // provBasket.addItemBasket(BasketItem(
    //     name: "NMAE", price: 200.30, description: "desctiprion simple"));
    contextW = context;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            content(context), //Верх приложения, меню
            Container(
              height: 350,
              //Сначала создаем список ссылок, потом создаем список виджетов, потом вкладываем это все карусель
              child: slider(loadListWidgetCarousel(listURL_image)), //Слайдер
            ),

            Expanded(
                //низ приложения
                child: Row(
              children: [
                (MediaQuery.of(context).size.height < 880)
                    ? Container()
                    : Expanded(
                        //Блок слева
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 15, bottom: 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)),
                          width: 250,
                          child: Column(
                            children: [
                              Container(
                                //Общий блок
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(provBasket
                                              .itemsBasket.length
                                              .toString()),
                                          margin: EdgeInsets.all(15),
                                          //левый подблок
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54)),
                                          height: 150,
                                          width: 150,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          margin: EdgeInsets.all(15),
                                          //правый подблок
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54)),
                                          height: 150,
                                          width: 150,
                                        ))
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black54)),
                                      margin: EdgeInsets.all(15),
                                      width: double.infinity)),
                              SizedBox(
                                height: 100,
                              ),
                              Container(
                                child: Text("Button"),
                                margin: EdgeInsets.all(15),
                                width: 250,
                                height: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54)),
                              )
                            ],
                          ),
                        )),
                (MediaQuery.of(context).size.height < 880)
                    ? Container()
                    : SizedBox(
                        width: 100,
                      ),
                Expanded(
                    //блок справа
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        color: Colors.white70,
                      ),
                      margin: EdgeInsets.only(right: 50, bottom: 15),
                      child: (MediaQuery.of(context).size.width < 800)
                          ? //Если ширина страницы меньше 800 то вывести это, если нет то
                          ListView.builder(
                              itemCount: basketItem.length,
                              itemBuilder: (context, index) {
                                return _itemList(index, basketItem);
                              })
                          : //
                          GridView.count(
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              crossAxisCount: 3,
                              // Generate 100 widgets that display their index in the List.
                              children:
                                  List.generate(basketItem.length, (index) {
                                return _itemList(index, basketItem);
                              }),
                            ),
                      // GridView.builder(
                      //     //то вывести это
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 4, //паралельно 3
                      //             crossAxisSpacing:
                      //                 16, //расстояние между ними по горизонтали
                      //             mainAxisSpacing:
                      //                 16 //расстояние между ними по вертикали
                      //             ),
                      //     itemBuilder: (context, index) {
                      //       return ListView.builder(
                      //           itemCount: basketItem.length,
                      //           itemBuilder: (context, index) {
                      //             return _itemList(index, basketItem);
                      //           });
                      //     })
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }

  ///Создаем  список виджетов для карусели
  List<Widget> loadListWidgetCarousel(List<String> listW) {
    listItem = listW.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(color: Colors.amber),
            child: CachedNetworkImage(
              imageUrl: i,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, image) {
                return Image(
                  image: image,
                  fit: BoxFit.none,
                );
              },
            ),
          );
        },
      );
    }).toList();
    return listItem;
  }

  Widget _itemList(int index, List<BasketItem> listB) {
    //Чтобы по 50 раз одно и тоже не писать мы выносим его в отдельный метод, где возврашаем наш виджет
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15, top: 15),
      color: Colors.transparent,
      child: Center(
        child: Container(
            //общий
            width: 275,
            height: 500,
            color: Colors.white70,
            child: Column(
              children: [
                Container(
                  //Картинка
                  child: CachedNetworkImage(
                    imageUrl: listB[index].imageUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 5),

                  height: 250,
                  width: 150,
                ),
                Container(
                    //Описание
                    height: 50,
                    child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Имя: " + listB[index].name.toString()),
                            Text("Цена: " +
                                listB[index].price.toString() +
                                " Руб"),
                            Text("Описание: " +
                                listB[index].description.toString())
                          ],
                        ))),
                GestureDetector(
                    //Кнопка
                    onTap: () {
                      provBasket.addItemBasket(listB[0]);
                      // print("${index} object");
                    },
                    child: Container(
                      child: Center(
                          child: Text("Добавить",
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ))),
                      height: 50,
                      width: 250,
                    ))
              ],
            )),
      ),
    );
  }

  content(context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      padding: EdgeInsets.only(right: 15, left: 15),
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            color: Colors.red,
          ),
          Spacer(),
          Container(
            child: (MaterialButton(
                height: 30,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BasketHome()));
                })),
            height: 30,
            width: 30,
            color: Colors.green,
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            height: 30,
            width: 30,
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  slider(List<Widget> listWidget) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: Colors.grey[200],
            ),
            height: 350,
            width: double.infinity,
            child: CarouselSlider(
                items: listWidget,
                carouselController: _controller,
                options: CarouselOptions(
                  height: 400,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (intW, asd) {
                    provCarousel.changeIndex(intW);
                  },
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ),
        Positioned(
          bottom: 15,
          right: MediaQuery.of(contextW!).size.width / 2 - 50,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listItem.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            (Theme.of(contextW!).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(provCarousel.indexInd == entry.key
                                    ? 0.9
                                    : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
