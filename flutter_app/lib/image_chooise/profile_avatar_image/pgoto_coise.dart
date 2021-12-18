import 'dart:typed_data';



import 'package:flutter_app/image_chooise/bloc/profileimage_block.dart';
import 'package:flutter_app/image_chooise/bloc/profileimage_event.dart';
import 'package:flutter_app/image_chooise/bloc/profileimage_state.dart';
import 'package:flutter_app/image_chooise/profile_avatar_image/asset_processing.dart';

import './image_demo_editor.dart';
import './page_editor_image.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

typedef MyCallback = String Function(Object?);

class PhotoChoise extends StatefulWidget {
  PhotoChoise({Key? key}) : super(key: key);

  @override
  _PhotoChoiseState createState() => _PhotoChoiseState();
}

class _PhotoChoiseState extends State<PhotoChoise>
    with TickerProviderStateMixin {
  late ProfileImageBloc _bloc;

  @override
  void initState() {
    _bloc = ProfileImageBloc(ChooseNo());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buttonSheetCustom(context);
  }

  bool _isTapDropDown = false;

  Widget buttonSheetCustom(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,                
                ),
                Spacer(),                  

                BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) =>
                      // if(state is )return;
                      // return
                      GestureDetector(
                    onTap: () {
                      // stateDrop();
                      if (state is OpenListPath) {
                        _bloc.add(CloseEvent());
                      } else if (state is CloseListPath) {
                        _bloc.add(OpenEvent());
                      } else {
                        _bloc.add(OpenEvent());
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 170,
                      // height: 40,
                      color: Colors.transparent,
                      child: Text("Галерея",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),

                Spacer(),

                IconButton(
                    alignment: Alignment.centerRight,
                    iconSize: 30,
                    onPressed: () {
                      _dataChoise;
                      Navigator.pop(context, _dataChoise);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
          ),
          Expanded(
              child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder(
                        bloc: _bloc,
                        builder: (context, state) {
                          if (state is CloseListPath) {
                            if (state.index == null) {
                              return gridViewFuture(context, 0);
                            } else {
                              return gridViewFuture(context, state.index!);
                            }
                          }
                          return gridViewFuture(context, 0);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder(
                        bloc: _bloc,
                        builder: (context, state) {
                          // child:
                          if (state is Chosen) {
                            return buttonA(context, true,
                                image: state.imageBytes);
                          }
                          return buttonA(context, false);
                        }),
                  ],
                ),
              ),
              BlocBuilder(
                bloc: _bloc,
                builder: (context, state) => Visibility(
                    visible: state is OpenListPath,
                    child: Positioned.fill(
                      child: Container(
                          color: Colors.white, child: listNamePath(context)),
                    )),
              )
            ],
          )),
          SizedBox(height: 20),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  //TODO: не работает, что делать?
  void _showToast(BuildContext context) {
    // final scaffold = Scaffold.of(context);
    // scaffold.showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.black87,
    //     content: const Text(
    //       'Выберите фото',
    //       style: TextStyle(color: Colors.red),
    //     ),
    //     action: SnackBarAction(
    //       label: '',
    //       onPressed: scaffold.hideCurrentSnackBar,
    //     ),
    //   ),
    // );
  }

  Widget buttonA(BuildContext context, bool click, {Uint8List? image}) {
    return GestureDetector(
      onTap: () {
        if (click == true) {
          //  if(state is Chosen){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SimpleImageEditor(image!),
              // ImageEditorDemo(image!),
              //  PageEditorImage(image:image! ,)
            ),
          );
          // }
        } else {
          //показать toast
          // buttonSheetCustom(context)
          _showToast(context);
        }
      },
      child: Container(
        // alignment: Alignment.bottomCenter,
        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        color: Colors.white,
        child: Center(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width < 800
                ? MediaQuery.of(context).size.width
                : 800,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),              
                color: click ? Color(0xff536EFC) : Color(0xff949FDA)),
            child: Center(
              child: Text(
                "Далее",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  

  // _listNamePath <- listNamePath
  Widget listNamePath(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<AssetPathEntity>>(
            future: getNListNamePath(),
            builder: (context, AsyncSnapshot<List<AssetPathEntity>> assync) {
              if (assync.hasData) {
                return getViewListNamePath(assync.data!);
              } else if (assync.hasError) {
                return Center(
                  child: SizedBox(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    width: 60,
                    height: 60,
                  ),
                );
              } else {
                return Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                );
              }
              // if(platform.isIOS){ // ios progress indicatior }
              // return CircularProgressIndicator();
            }),
      ),
    );
  }

  // _getViewListNamePath <- getViewListNamePath
  Widget getViewListNamePath(List<AssetPathEntity> data) {
    return ListView.separated(
        separatorBuilder: (_, __) => Container(
              margin: const EdgeInsetsDirectional.only(start: 60),
              height: 3,
              // color: theme.canvasColor,
            ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              // if(state is OpenListPath)
              //TODO: при нажати ни чего не изменяется
              return GestureDetector(
                  onTap: () {
                    print("выбор папки");
                    // widget.chooisePath!(index); //data[index]  - AssetPathEntity
                    _bloc.add(ListPathChoise(index, data));
                    // _bloc.add(CloseEvent());
                  },
                  child: getItemListName(data[index]));

              // return Text("S");
            },
          );
        });
  }

  Widget getItemListName(AssetPathEntity data) {
    // data.name;
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          FutureBuilder<Uint8List?>(
              future: getFirstThumbFromPathEntity(data),
              builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: snapshot.data == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(snapshot.data!),
                          ),
                  ),
                );
              }),
          SizedBox(
            width: 8,
          ),
          Container(
              padding: EdgeInsets.all(8),
              child: Center(
                  child: Text(
                data.name,
                style: TextStyle(fontSize: 18),
              ))),
          Spacer(),
          Container(
              padding: EdgeInsets.all(8),
              child: Center(
                  child: Text(
                "(" + data.assetCount.toString() + ")",
                style: TextStyle(fontSize: 18),
              ))),
        ],
      ),
    );
  }

  Widget gridViewFuture(BuildContext context, int choise) {
    return FutureBuilder<List<AssetEntity>?>(
        future: loadAssetList(0),
        builder: (context, AsyncSnapshot<List<AssetEntity>?> assync) {
          if (assync.hasData) {
            return getGridView(assync.data!);
          } else if (assync.hasError) {
            return Center(
              child: Container(
                height: 60,
                width: 60,
                child: SizedBox(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  width: 50,
                  height: 50,
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                height: 60,
                width: 60,
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 50,
                  height: 50,
                ),
              ),
            );
          }
          // if(platform.isIOS){ // ios progress indicatior }
          // return CircularProgressIndicator();
        });
  }

  Widget getGridView(List<AssetEntity> data) {
    return

        // SliverGrid(
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 3,
        //     ),
        //     delegate: SliverChildBuilderDelegate(
        //       (BuildContext context, int index) => getItemGrid(data[index], context),
        //   )
        // );

        GridView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is Chosen) {
              if (state.index != null) {
                return getItemGrid(data[index], index, context,
                    state.index == index ? true : false, state);
              } else {
                return getItemGrid(data[index], index, context, false, state);
              }
            }

            return getItemGrid(data[index], index, context, false, state);
          }),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        // childAspectRatio: 0,
      ),
    );
  }

  int _selectN = 09090;
  Uint8List? _dataChoise = null;

  Widget getItemGrid(AssetEntity data, int index, BuildContext context,
      bool choiseB, Object? ste) {
    // favorit
    // data.isFavorite = true;

    return MyAnimatedSizeWidget(
      child: FutureBuilder(
          future: getImg(data),
          builder: (context, AsyncSnapshot<Uint8List?> assyn) {
            return GestureDetector(
              onTap: () async {
                if (ste is Chosen) {
                  if (ste.index == index) {
                    _bloc.add(GridElementChooseNO());
                    // data.isFavorite = !data.isFavorite ;
                  }
                } else if (ste is ChooseNo) {
                  _bloc.add(GridElementChoose(index, assyn.data!));
                  // data.isFavorite = !data.isFavorite ;
                }
              },
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    //Image
                    Positioned(
                        child:
                            // FutureBuilder<Uint8List?>(
                            //     future: getImg(data),
                            //     builder: (context, AsyncSnapshot<Uint8List?> async) =>
                            // GestureDetector(
                            //   onTap: (){
                            //       //Препросмотр
                            //   },
                            //   child:
                            getImage(assyn.data, choiseB ? 85 : 150,
                                choiseB ? 85 : 150)
                        // )
                        // )
                        ),
                    //Пометить что он выбран
                    Positioned(
                      top: 5,
                      right: 5,
                      // child: GestureDetector(
                      //   onTap: (){
                      //       // просто выбор
                      //   },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          onPressed: () {},
                          icon: choiseB
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.radio_button_unchecked,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      // )
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<Uint8List?> getImg(AssetEntity data) async {
    Uint8List? bytes = await data.thumbDataWithSize(150, 150);
    return bytes;
  }

  Widget getImage(Uint8List? bytes, double wid, double hid) {
    // Uint8List? bytes = await data.thumbDataWithSize(30 ,30 );

    return Center(
      child: Container(
        width: wid,
        height: hid,
        decoration: BoxDecoration(
          image: bytes == null
              ? null
              : DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(bytes),
                ),
        ),
      ),
    );
  }
}

class MyAnimatedSizeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const MyAnimatedSizeWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _AnimatedSizeWidgetState createState() => _AnimatedSizeWidgetState();
}

class _AnimatedSizeWidgetState extends State<MyAnimatedSizeWidget>
    with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: widget.duration,
      child: widget.child,
      curve: Curves.easeInOut,
    );
  }
}
