import 'package:carousel_slider/carousel_slider.dart';
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
            content(),
            slider(),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54)),
                      width: 250,
                    )),
                SizedBox(
                  width: 100,
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          color: Colors.blue,
                        ),
                        margin: EdgeInsets.only(right: 50),
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
                                        crossAxisCount: 4, //паралельно 3
                                        crossAxisSpacing:
                                            16, //расстояние между ними по горизонтали
                                        mainAxisSpacing:
                                            16 //расстояние между ними по вертикали
                                        ),
                                itemBuilder: (context, index) {
                                  return _itemList(index);
                                }))),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _itemList(int index) {
    //Чтобы по 50 раз одно и тоже не писать мы выносим его в отдельный метод, где возврашаем наш виджет
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      color: Colors.transparent,
      child: Center(
        child: Container(
            width: 100,
            height: 100,
            color: Colors.blueGrey[300],
            child: Text("Item $index")),
      ),
    );
  }

  content() {
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

  slider() {
    return Container(
      height: 350,
      width: double.infinity,
    );
  }
}

// class ImageSliderDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Image slider demo')),
//       body: Container(
//           child: CarouselSlider(
//         options: CarouselOptions(),
//         items: imgList
//             .map((item) => Container(
//                   child: Center(
//                       child:
//                           Image.network(item, fit: BoxFit.cover, width: 1000)),
//                 ))
//             .toList(),
//       )),
//     );
//   }
// }

// final List<Widget> imageSliders = imgList
//     .map((item) => Container(
//           child: Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                 child: Stack(
//                   children: <Widget>[
//                     Image.network(item, fit: BoxFit.cover, width: 1000.0),
//                     Positioned(
//                       bottom: 0.0,
//                       left: 0.0,
//                       right: 0.0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(200, 0, 0, 0),
//                               Color.fromARGB(0, 0, 0, 0)
//                             ],
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                           ),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 20.0),
//                         child: Text(
//                           'No. ${imgList.indexOf(item)} image',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ))
//     .toList();
// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];
