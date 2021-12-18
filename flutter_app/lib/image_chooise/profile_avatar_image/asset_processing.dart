



import 'dart:io';
import 'dart:typed_data';

// import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_manager/photo_manager.dart';





  Future<Uint8List?> getFirstThumbFromPathEntity(
    AssetPathEntity pathEntity,
  ) async {
    final AssetEntity asset = (await pathEntity.getAssetListRange(
      start: 0,
      end: 1,
    ))
        .elementAt(0);
    final Uint8List? assetData =
        await asset.thumbDataWithSize(150, 150);
    return assetData;
  }



  Future<List<AssetEntity>?> loadAssetList(int chooise) async {
    print('getSDfn()');
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {       
        // get list path image
        List<AssetPathEntity> list = await PhotoManager.getAssetPathList();

        //////
        print(' List<AssetPathEntity> list : '+list.length.toString() );
        for(int i = 0; i<list.length;  i++){
          print(' for( i < imageList.length;'+"\n");
                
          print(' List<AssetPathEntity> list : '+list[i].name.toString() );          
        }      
        print(' List<AssetPathEntity> list : '+list[list.length == 0 ? 0 :list.length -1].name.toString() );
        //////

       List<AssetEntity> result =  await chooisePack(list[chooise]);

        return result;
    } else {
        // fail
        /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
        return null;
    }


  }

    Future<List<AssetPathEntity>> getNListNamePath() async {
    print('getSDfn()');
    var result = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> list = [];
    if (result.isAuth) {       
        // get list path image
         list += await PhotoManager.getAssetPathList();

  
        //////
        print(' List<AssetPathEntity> list : '+list.length.toString() );
        for(int i = 0; i<list.length;  i++){
          print(' for( i < imageList.length;'+"\n");
                
          print(' List<AssetPathEntity> list : '+list[i].name.toString() );          
        }      
        print(' List<AssetPathEntity> list : '+list[list.length -1].name.toString() );
        //////

      //  List<AssetEntity> result =  await chooisePack(list[chooise]);

        return list;
    } else {
        // fail
        /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
        return list;
    }


  }

  // get list image
  Future< List<AssetEntity> > chooisePack(AssetPathEntity path) async {
        AssetPathEntity data = path; // 1st album in the list, typically the "Recent" or "All" album
        List<AssetEntity> imageList = await data.assetList;

        // List<AssetEntity> result = [];
        // for(int i = 0; i<imageList.length;  i++){
        //   print(' for(int i = 0; i<imageList.length;  i++){ '+"\n");

        //     result.add( 
        //       await getImageInfo(imageList[i])  
        //      );  
        // }

        return imageList;
  }

  //   chooisePack(List<AssetPathEntity> path) async {
  //       AssetPathEntity data = path[0]; // 1st album in the list, typically the "Recent" or "All" album
  //       List<AssetEntity> imageList = await data.assetList;
  //       for(int i = 0; i<imageList.length;  i++){
  //         print(' for(int i = 0; i<imageList.length;  i++){ ');
  //         // getImageInfo(imageList[i]);
  //       }
        
  // }

  Future<AssetEntity> getImageInfo(AssetEntity entityMy) async {
      print(" getImageInfo(AssetEntity entityMy) async { ");
      // AssetEntity entity = entityMy;

      // File? file = await entity.file; // image file

      // Uint8List? originBytes = await entity.originBytes; // image/video original file content,

      // Uint8List? thumbBytes = await entity.thumbData; // thumb data ,you can use Image.memory(thumbBytes); size is 64px*64px;

      // Uint8List? thumbDataWithSize = await entity.thumbDataWithSize(50 ,50 ); //(width,height); //Just like thumbnails, you can specify your own size. unit is px; 
      //       //format is optional support jpg and png.

      // AssetType type = entity.type; // the type of asset enum of other,image,video

      // Duration duration = entity.videoDuration; //if type is not video, then return null.

      // Size size = entity.size;

      // int width = entity.width;

      // int height = entity.height;

      // DateTime createDt = entity.createDateTime;

      // DateTime modifiedDt = entity.modifiedDateTime;

      // /// Gps info of asset. If latitude and longitude is 0, it means that no positioning information was obtained.
      // /// This information is not necessarily available, because the photo source is not necessarily the camera.
      // /// Even the camera, due to privacy issues, this property must not be available on androidQ and above.
      // double latitude = entity.latitude;
      // double longitude = entity.longitude;

      // // Latlng latlng = await entity.latlngAsync(); // In androidQ or higher, need use the method to get location info.

      // String? mediaUrl = await entity.getMediaUrl(); /// It can be used in some video player plugin to preview, such as [flutter_ijkplayer](https://pub.dev/packages/flutter_ijkplayer)

      // String? title = entity.title; // Since this property is fetched using KVO in iOS, the default is null, please use titleAsync to get it.

      // String? relativePath = entity.relativePath; // It is always null in iOS.


    return entityMy;
  }


  // Future<Uint8List?> getImg(AssetEntity data) async {
  //   Uint8List? bytes = await data.thumbDataWithSize(150, 150);
  //   return bytes;
  // }

  // Widget getImage(Uint8List? bytes) {
  //   // Uint8List? bytes = await data.thumbDataWithSize(30 ,30 );

  //   return
  //       // final decoration = new BoxDecoration(
  //       //   image: bytes == null ? null :
  //       //   new DecorationImage(
  //       //     image: new MemoryImage(bytes),
  //       //   ),
  //       // );

  //       Container(
  //     // width: 150,
  //     // height: 150,
  //     decoration: BoxDecoration(
  //       image: bytes == null
  //           ? null
  //           : DecorationImage(
  //               fit: BoxFit.cover,
  //               image: MemoryImage(bytes),
  //             ),
  //     ),
  //   );
  // }
