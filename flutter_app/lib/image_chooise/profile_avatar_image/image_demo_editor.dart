import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

// import 'package:example/common/image_picker/image_picker.dart';
// import 'package:example/common/utils/crop_editor_helper.dart';
// import 'package:example/common/widget/common_widget.dart';




import 'package:shared_preferences/shared_preferences.dart';

import './hard.dart';
import 'package:extended_image/extended_image.dart';
// import 'package:ff_annotation_route_core/ff_annotation_route_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:oktoast/oktoast.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

//import 'package:image_picker/image_picker.dart' as picker;
// import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

//import 'dart:typed_data';
// import 'dart:isolate';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:flutter/foundation.dart';

// ignore: implementation_imports
// import 'package:http/src/response.dart';
// import 'package:http_client_helper/http_client_helper.dart';

// import 'package:isolate/load_balancer.dart';
// import 'package:isolate/isolate_runner.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:image/image.dart';
// import 'package:image_editor/image_editor.dart';

class AspectRatioItem {
  AspectRatioItem({this.value, this.text});
  final String? text;
  final double? value;
}

class AspectRatioWidget extends StatelessWidget {
  const AspectRatioWidget(
      {this.aspectRatioS, this.aspectRatio, this.isSelected = false});
  final String? aspectRatioS;
  final double? aspectRatio;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: AspectRatioPainter(
          aspectRatio: aspectRatio,
          aspectRatioS: aspectRatioS,
          isSelected: isSelected),
    );
  }
}

class AspectRatioPainter extends CustomPainter {
  AspectRatioPainter(
      {this.aspectRatioS, this.aspectRatio, this.isSelected = false});
  final String? aspectRatioS;
  final double? aspectRatio;
  final bool isSelected;
  @override
  void paint(Canvas canvas, Size size) {
    final Color color = isSelected ? Colors.blue : Colors.grey;
    final Rect rect = Offset.zero & size;
    //https://github.com/flutter/flutter/issues/49328
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final double aspectRatioResult =
        (aspectRatio != null && aspectRatio! > 0.0) ? aspectRatio! : 1.0;
    canvas.drawRect(
        getDestinationRect(
            rect: const EdgeInsets.all(10.0).deflateRect(rect),
            inputSize: Size(aspectRatioResult * 100, 100.0),
            fit: BoxFit.contain),
        paint);

    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: aspectRatioS,
            style: TextStyle(
              color:
                  color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
              fontSize: 16.0,
            )),
        textDirection: TextDirection.ltr,
        maxLines: 1);
    textPainter.layout(maxWidth: rect.width);

    textPainter.paint(
        canvas,
        rect.center -
            Offset(textPainter.width / 2.0, textPainter.height / 2.0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is AspectRatioPainter &&
        (oldDelegate.isSelected != isSelected ||
            oldDelegate.aspectRatioS != aspectRatioS ||
            oldDelegate.aspectRatio != aspectRatio);
  }
}

class SimpleImageEditor extends StatefulWidget {
  Uint8List imageS;
  SimpleImageEditor(this.imageS);

  @override
  _SimpleImageEditorState createState() => _SimpleImageEditorState();
}

class _SimpleImageEditorState extends State<SimpleImageEditor> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  bool _cropping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: 
        backgroundColor: Colors.purple,
        title: const Text('ImageEditor'),
      ),
      body: ExtendedImage.memory(
        widget.imageS,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        enableLoadState: true,
        extendedImageEditorKey: editorKey,
        cacheRawData: true,
        initEditorConfigHandler: (ExtendedImageState? state) {
          return EditorConfig(
              maxScale: 8.0,
              cropRectPadding: const EdgeInsets.all(20.0),
              hitTestSize: 20.0,
              initCropRectType: InitCropRectType.imageRect,
              cropAspectRatio: CropAspectRatios.ratio4_3,
              editActionDetailsIsChanged: (EditActionDetails? details) {
                print(details?.totalScale);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
          child: const Icon(Icons.crop),
          onPressed: () {
             Navigator.pop(context);
            Navigator.pop(context);
            cropImage(context);
          }),
    );
  }

  Future<void> cropImage(BuildContext context) async {
    if (_cropping) {
      return;
    }
    final Uint8List fileData = Uint8List.fromList(
            (await cropImageDataWithNativeLibraryM(
                  state: editorKey.currentState!))!);
        // kIsWeb
        // ? (await cropImageDataWithDartLibrary(state: editorKey.currentState!))!
        // :
        

    //  showDialog(context: context, builder: (BuildContext context){
    //     return  Container(
    //               width: 50,
    //               height: 50,
    //               decoration: BoxDecoration(
    //                 image: fileData == null
    //                     ? null
    //                     : DecorationImage(
    //                         fit: BoxFit.cover,
    //                         image: MemoryImage(fileData),
    //                       ),
    //               ),
    //             );
    //   });

    //TODO: Save local avatar
    final String? fileFath =
        await ImageSaver.save('avatar_profile.jpg', fileData);


    

    // showToast('save image : $fileFath');
    _cropping = false;
  }
}

class ImageEditorDemo extends StatefulWidget {
  Uint8List imageW;
  ImageEditorDemo(this.imageW);

  @override
  _ImageEditorDemoState createState() => _ImageEditorDemoState();
}

class _ImageEditorDemoState extends State<ImageEditorDemo> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  final GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>> popupMenuKey =
      GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>>();
  final List<AspectRatioItem> _aspectRatios = <AspectRatioItem>[
    AspectRatioItem(text: 'custom', value: CropAspectRatios.custom),
    AspectRatioItem(text: 'original', value: CropAspectRatios.original),
    AspectRatioItem(text: '1*1', value: CropAspectRatios.ratio1_1),
    AspectRatioItem(text: '4*3', value: CropAspectRatios.ratio4_3),
    AspectRatioItem(text: '3*4', value: CropAspectRatios.ratio3_4),
    AspectRatioItem(text: '16*9', value: CropAspectRatios.ratio16_9),
    AspectRatioItem(text: '9*16', value: CropAspectRatios.ratio9_16)
  ];
  AspectRatioItem? _aspectRatio;
  bool _cropping = false;

  EditorCropLayerPainter? _cropLayerPainter;
  Uint8List? _memoryImage;
  @override
  void initState() {
    _memoryImage = widget.imageW;
    _aspectRatio = _aspectRatios.first;
    _cropLayerPainter = const EditorCropLayerPainter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.purple,
        foregroundColor:  Colors.purple,
        title: const Text('image editor'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.photo_library),
        //     onPressed: _getImage,
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.done),
        //     onPressed: () {
        //       // if (kIsWeb) {

        //       _cropImage(true, context);
        //       // }
        //       // else {
        //       //   _showCropDialog(context);
        //       // }
        //     },
        //   ),
        // ],
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: _memoryImage != null
                ? ExtendedImage.memory(
                    _memoryImage!,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    enableLoadState: true,
                    extendedImageEditorKey: editorKey,
                    initEditorConfigHandler: (ExtendedImageState? state) {
                      return EditorConfig(
                        maxScale: 8.0,
                        cropRectPadding: const EdgeInsets.all(20.0),
                        hitTestSize: 20.0,
                        cropLayerPainter: _cropLayerPainter!,
                        initCropRectType: InitCropRectType.imageRect,
                        cropAspectRatio: _aspectRatio!.value,
                      );
                    },
                    cacheRawData: true,
                  )
                : Center(
                    child: Text("Error editor"),
                  )
            // :
            // ExtendedImage.asset(
            //     'assets/image.jpg',
            
            ),
      ]),
      bottomNavigationBar: BottomAppBar(
        //color: Colors.lightBlue,
        shape: const CircularNotchedRectangle(),
        child: ButtonTheme(
          minWidth: 0.0,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.crop),
                // label: const Text(
                //   'Crop',
                //   style: TextStyle(fontSize: 10.0),
                // ),
                // textColor: Colors.white,
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: <Widget>[
                            const Expanded(
                              child: SizedBox(),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(20.0),
                                itemBuilder: (_, int index) {
                                  final AspectRatioItem item =
                                      _aspectRatios[index];
                                  return GestureDetector(
                                    child: AspectRatioWidget(
                                      aspectRatio: item.value,
                                      aspectRatioS: item.text,
                                      isSelected: item == _aspectRatio,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _aspectRatio = item;
                                      });
                                    },
                                  );
                                },
                                itemCount: _aspectRatios.length,
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
              IconButton(
                icon: const Icon(Icons.flip),
                // label: const Text(
                //   'Flip',
                //   style: TextStyle(fontSize: 10.0),
                // ),
                // textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.flip();
                },
              ),
              IconButton(
                icon: const Icon(Icons.rotate_left),
                // label: const Text(
                //   'Rotate Left',
                //   style: TextStyle(fontSize: 8.0),
                // ),
                // textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.rotate(right: false);
                },
              ),
              IconButton(
                icon: const Icon(Icons.rotate_right),
                // label: const Text(
                //   'Rotate Right',
                //   style: TextStyle(fontSize: 8.0),
                // ),
                // textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.rotate(right: true);
                },
              ),
          
              IconButton(
                icon: const Icon(Icons.restore),
                // label: const Text(
                //   'Reset',
                //   style: TextStyle(fontSize: 10.0),
                // ),
                // textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _cropImage(bool useNative, context) async {
    // if (_cropping) {
    //   return;
    // }
    String msg = '';
    try {
      _cropping = true;

      //await showBusyingDialog();

      Uint8List? fileData;

      /// native library
      // if (useNative) {
      fileData =
          await cropImageDataWithNativeLibraryM(state: editorKey.currentState!);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: fileData == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(fileData),
                      ),
              ),
            );
          });
      // }
      // else {
      //   ///delay due to cropImageDataWithDartLibrary is time consuming on main thread
      //   ///it will block showBusyingDialog
      //   ///if you don't want to block ui, use compute/isolate,but it costs more time.
      //   //await Future.delayed(Duration(milliseconds: 200));

      //   ///if you don't want to block ui, use compute/isolate,but it costs more time.
      //   fileData =
      //       await cropImageDataWithDartLibrary(state: editorKey.currentState!);
      // }
      final String? filePath =
          await ImageSaver.save('avatar_profile.jpg', fileData!);
      // var filePath = await ImagePickerSaver.saveFile(fileData: fileData);

      msg = 'save image : $filePath';
      //TODO
      Navigator.pop(context);
      
      // Navigator.pop(context);
    } catch (e, stack) {
      msg = 'save failed: $e\n $stack';
      print(msg);
    }

    //Navigator.of(context).pop();
    // showToast(msg);
    _cropping = false;
  }

  // Uint8List? _memoryImage;
  Future<void> _getImage() async {
    // _memoryImage = await pickImage(context);
    //when back to current page, may be editorKey.currentState is not ready.
    // Future<void>.delayed(const Duration(milliseconds: 200), () {
    //   setState(() {
    //     editorKey.currentState!.reset();
    //   });
    // });
  }
}

class CustomEditorCropLayerPainter extends EditorCropLayerPainter {
  const CustomEditorCropLayerPainter();
  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Paint paint = Paint()
      ..color = painter.cornerColor
      ..style = PaintingStyle.fill;
    final Rect cropRect = painter.cropRect;
    const double radius = 6;
    canvas.drawCircle(Offset(cropRect.left, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.left, cropRect.bottom), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.bottom), radius, paint);
  }
}

class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  const CircleEditorCropLayerPainter();

  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    // do nothing
  }

  @override
  void paintMask(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect rect = Offset.zero & size;
    final Rect cropRect = painter.cropRect;
    final Color maskColor = painter.maskColor;
    canvas.saveLayer(rect, Paint());
    canvas.drawRect(
        rect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = maskColor);
    canvas.drawCircle(cropRect.center, cropRect.width / 2.0,
        Paint()..blendMode = BlendMode.clear);
    canvas.restore();
  }

  @override
  void paintLines(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect cropRect = painter.cropRect;
    if (painter.pointerDown) {
      canvas.save();
      canvas.clipPath(Path()..addOval(cropRect));
      super.paintLines(canvas, size, painter);
      canvas.restore();
    }
  }
}

Future<Uint8List?> pickImage(BuildContext context) async {
  List<AssetEntity> assets = <AssetEntity>[];
  return null;
  // final List<AssetEntity>? result =
  //   await AssetPicker.pickAssets(
  //     context,
  //     maxAssets: 1,
  //     pathThumbSize: 84,
  //     gridCount: 3,
  //     pageSize: 300,
  //     selectedAssets: assets,
  //     requestType: RequestType.image,
  //   // textDelegate: EnglishTextDelegate(),
  // );
  // if (result != null) {
  //   assets = List<AssetEntity>.from(result);
  //   return assets.first.originBytes;
  // }
  // return null;
  // final File file =

  //     await picker.ImagePicker.pickImage(source: picker.ImageSource.gallery);
  // return file.readAsBytes();
}

class ImageSaver {
  static Future<String?> save(String name, Uint8List fileData) async {
    final AssetEntity? imageEntity =
        await PhotoManager.editor.saveImage(fileData);
    final File? file = await imageEntity?.file;
    SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('image', file!.path.toString());
    return file.path;
  }
  static Future<String?> getImage() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String image = prefs.getString('image')??'';
      return image;
  }
}

// //import 'dart:typed_data';
// import 'dart:isolate';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:flutter/foundation.dart';

// // ignore: implementation_imports
// import 'package:http/src/response.dart';
// import 'package:http_client_helper/http_client_helper.dart';

// // import 'package:isolate/load_balancer.dart';
// // import 'package:isolate/isolate_runner.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:image/image.dart';
// import 'package:image_editor/image_editor.dart';

// final Future<LoadBalancer> loadBalancer =
//     LoadBalancer.create(1, IsolateRunner.spawn);

// Future<dynamic> isolateDecodeImage(List<int> data) async {
//   final ReceivePort response = ReceivePort();
//   await Isolate.spawn(_isolateDecodeImage, response.sendPort);
//   final dynamic sendPort = await response.first;
//   final ReceivePort answer = ReceivePort();
//   // ignore: always_specify_types
//   sendPort.send([answer.sendPort, data]);
//   return answer.first;
// }

// void _isolateDecodeImage(SendPort port) {
//   final ReceivePort rPort = ReceivePort();
//   port.send(rPort.sendPort);
//   rPort.listen((dynamic message) {
//     final SendPort send = message[0] as SendPort;
//     final List<int> data = message[1] as List<int>;
//     send.send(decodeImage(data));
//   });
// }

// Future<dynamic> isolateEncodeImage(Image src) async {
//   final ReceivePort response = ReceivePort();
//   await Isolate.spawn(_isolateEncodeImage, response.sendPort);
//   final dynamic sendPort = await response.first;
//   final ReceivePort answer = ReceivePort();
//   // ignore: always_specify_types
//   sendPort.send([answer.sendPort, src]);
//   return answer.first;
// }

// void _isolateEncodeImage(SendPort port) {
//   final ReceivePort rPort = ReceivePort();
//   port.send(rPort.sendPort);
//   rPort.listen((dynamic message) {
//     final SendPort send = message[0] as SendPort;
//     final Image src = message[1] as Image;
//     send.send(encodeJpg(src));
//   });
// }

Future<Uint8List?> cropImageDataWithNativeLibraryM(
    {required ExtendedImageEditorState state}) async {
  print('native library start cropping');

  final Rect? cropRect = state.getCropRect();
  final EditActionDetails action = state.editAction!;

  final int rotateAngle = action.rotateAngle.toInt();
  final bool flipHorizontal = action.flipY;
  final bool flipVertical = action.flipX;
  final Uint8List img = state.rawImageData;

  final ImageEditorOption option = ImageEditorOption();

  // if (action.needCrop) {
  option.addOption(ClipOption.fromRect(cropRect!));
  // }

  // if (action.needFlip) {
  //   option.addOption(
  //       FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
  // }

  if (action.hasRotateAngle) {
    option.addOption(RotateOption(rotateAngle));
  }

  final DateTime start = DateTime.now();
  Uint8List? result = img;
  result = await editImage(
    image: img,
    imageEditorOption: option,
  );
  // await ImageEditor.editImage(
  //   image: img,
  //   imageEditorOption: option,
  // );

  print('${DateTime.now().difference(start)} ：total time');
  return result;
}

// Future<Uint8List?> editImage({
//   required Uint8List image,
//   required ImageEditorOption imageEditorOption,
// }) async {
//   Uint8List? tmp = image;
//   for (final group in imageEditorOption.groupList) {
//     if (group.canIgnore) {
//       continue;
//     }
//     final handler = ImageHandler.memory(tmp);
//     final editOption = ImageEditorOption();
//     for (final option in group) {
//       editOption.addOption(option);
//     }
//     editOption.outputFormat = imageEditorOption.outputFormat;

//     tmp = await handler.handleAndGetUint8List(editOption);
//   }

//   return tmp;
// }
