import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';

class PageEditorImage extends StatefulWidget {
  Uint8List image;
  PageEditorImage({Key? key, required this.image}) : super(key: key);

  @override
  _PageEditorImageState createState() => _PageEditorImageState();
}

class _PageEditorImageState extends State<PageEditorImage> {

  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            
            Container(
              padding: EdgeInsets.all(15),
               color: Colors.grey[350],
              child: Row(
                children: [
                  IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {}, icon: Icon(Icons.arrow_back_ios)
                  ),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit))
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  image: widget.image == null
                      ? null
                      : new DecorationImage(
                        fit: BoxFit.fitHeight,
                          image: new MemoryImage(widget.image),
                        ),
                )),
              ),
            ),
            Container(
              color: Colors.grey[350],
              height: 90,
              child: Center(
                child: Container(
                  height: 50,     
                  width:MediaQuery.of(context).size.width < 800 ?  MediaQuery.of(context).size.width - 50 : 800,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(8.0)),
                    //TODO: HEX color
                    color:  Color(0xff536EFC),
                  ),                              
                  child: Center(
                    child: Text(
                      "Подтвердить",
                      style: TextStyle(fontSize: 22, color: Colors.white ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //   bool _cropping = false;

  // Widget image(BuildContext context){
  //    return 
  //    ExtendedImage.asset
  //   //  .network
  //    (
  //     // imageTestUrl,
  //     assets,
  //     fit: BoxFit.contain,
  //     mode: ExtendedImageMode.editor,
  //     extendedImageEditorKey: editorKey,
  //     initEditorConfigHandler: (state) {
  //       return EditorConfig(
  //           maxScale: 8.0,
  //           cropRectPadding: EdgeInsets.all(20.0),
  //           hitTestSize: 20.0,
  //           // cropAspectRatio: _aspectRatio.aspectRatio
  //           );
  //     },
  //   );
  // }

  //  Future<void> cropImage() async {
  //   if (_cropping) {
  //     return;
  //   }
  //   final Uint8List fileData = Uint8List.fromList(
  //        (await cropImageDataWithNativeLibrary(
  //           state: editorKey.currentState!))!);
  //   // final String? fileFath =
  //   //     await ImageSaver.save('extended_image_cropped_image.jpg', fileData);

  //   //TODO: Save

  //   // showToast('save image : $fileFath');
  //   _cropping = false;
  // }

  // Future<Uint8List?> cropImageDataWithNativeLibrary(
  //     {required ExtendedImageEditorState state}) async {
  //   print('native library start cropping');

  //   final Rect? cropRect = state.getCropRect();
  //   final EditActionDetails action = state.editAction!;

  //   final int rotateAngle = action.rotateAngle.toInt();
  //   final bool flipHorizontal = action.flipY;
  //   final bool flipVertical = action.flipX;
  //   final Uint8List img = state.rawImageData;

  //   final ImageEditorOption option = ImageEditorOption();

  //   if (action.needCrop) {
  //     option.addOption(ClipOption.fromRect(cropRect!));
  //   }

  //   if (action.needFlip) {
  //     option.addOption(
  //         FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
  //   }

  //   if (action.hasRotateAngle) {
  //     option.addOption(RotateOption(rotateAngle));
  //   }

  //   final DateTime start = DateTime.now();
  //   final Uint8List? result = await ImageEditor.editImage(
  //     image: img,
  //     imageEditorOption: option,
  //   );

  //   print('${DateTime.now().difference(start)} ：total time');
  //   return result;
  // }

}
