import 'dart:typed_data';



import 'package:flutter/material.dart';
import 'package:flutter_app/image_chooise/bloc/profileimage_block.dart';
import 'package:flutter_app/image_chooise/bloc/profileimage_state.dart';
import 'package:flutter_app/image_chooise/profile_avatar_image/pgoto_coise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title:
              'Flutter Demo Home Page'), //Screen2ImageChooise() ,// MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Uint8List? image;
  MyHomePage({Key? key, this.image,  this.title}) : super(key: key);


  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  bool _isScrollDown = false;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  late ProfileImageBloc _bloc;
  @override
  void initState() {
    _bloc = ProfileImageBloc(Uninitialized());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  double _size = 50.0;
  bool _large = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title!),
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // BlocBuilder(
          //   bloc: _bloc,
          //   builder: (context, state) {
              // if (state is Chosen)
                // return 
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: widget.image == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(widget.image!),
                          ),
                  ),
                ),
              // return Container(
              //   width: 150,
              //   height: 150,
              //   color: Colors.indigo,
              // );
            // },
          // ),
          //  BlocBuilder(
          //   bloc: _bloc ,
          //   builder: (context, state){
          //     if(state is ChoiceYes)
          //       return ;
          //       return ;
          //   },
          // ),

          // Anims
          // GestureDetector(
          //   onTap: () => _updateSize(),
          //   child: Container(
          //     color: Colors.amberAccent,
          //     child: AnimatedSize(
          //       curve: Curves.easeIn,
          //       vsync: this,
          //       duration: const Duration(seconds: 1),
          //       child: FlutterLogo(size: _size),
          //     ),
          //   ),
          // ),
          SizedBox(height: 20,),

          // Container(
          //   height: 300,
          //   child: Expanded(
          //     child: Container(
          //       width: MediaQuery.of(context).size.width,
          //       child: FutureBuilder<List<AssetPathEntity>>(
          //           future: getNListNamePath(),
          //           builder:
          //               (context, AsyncSnapshot<List<AssetPathEntity>> assync) {
          //             if (assync.hasData) {
          //               return getViewListNamePath(assync.data!);
          //             } else if (assync.hasError) {
          //               return Center(
          //                 child: SizedBox(
          //                   child: Icon(
          //                     Icons.error,
          //                     color: Colors.red,
          //                   ),
          //                   width: 60,
          //                   height: 60,
          //                 ),
          //               );
          //             } else {
          //               return Center(
          //                 child: SizedBox(
          //                   child: CircularProgressIndicator(),
          //                   width: 60,
          //                   height: 60,
          //                 ),
          //               );
          //             }
          //             // if(platform.isIOS){ // ios progress indicatior }
          //             // return CircularProgressIndicator();
          //           }),
          //     ),
          //   ),
          // ),

          //     SizedBox(
          //       height: 40,
          //     ),
          //     // Text(
          //     //   'You have pushed the button this many times:',
          //     // ),
          //     // Text(
          //     //   '$_counter',
          //     //   style: Theme.of(context).textTheme.headline4,
          //     // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
          showMySheet(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  showMySheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        builder: (context) => PhotoChoise());
  }

  Widget getViewListNamePath(List<AssetPathEntity> data) {
    return ListView.separated(
        separatorBuilder: (_, __) => Container(
              margin: const EdgeInsetsDirectional.only(start: 60),
              height: 3,
              // color: theme.canvasColor,
            ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => print("выбор папки"),
              child: getItemListName(data[index]));
        });
  }

  Widget getItemListName(AssetPathEntity data) {
    return Row(
      children: [
        // Container(
        //     padding: EdgeInsets.all(8),
        //     child: Center(
        //         child: Text(
        //       data.name,
        //       style: TextStyle(fontSize: 18),
        //     ))),
        // Spacer(),
        Container(
            padding: EdgeInsets.all(8),
            child: Center(
                child: Text(
              "(" + data.assetCount.toString() + ")",
              style: TextStyle(fontSize: 18),
            ))),
      ],
    );
  }

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 100.0;
      _large = !_large;
    });
  }
}
