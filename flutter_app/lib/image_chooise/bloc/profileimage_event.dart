import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class ProfileImageEvent  {}

class AccomodationSuccessEvent extends ProfileImageEvent {
  AccomodationSuccessEvent();
}

class ListPathChoise extends ProfileImageEvent {
  int index;
  List<AssetPathEntity> pathList;
  ListPathChoise(this.index, this.pathList);
}

class GridElementChoose extends ProfileImageEvent {
  int index;
  Uint8List bytes;
  GridElementChoose(this.index, this.bytes);
  
}

class CloseEvent extends ProfileImageEvent{
  CloseEvent();
}
class OpenEvent extends ProfileImageEvent{
  OpenEvent();
}

class GridElementChooseNO extends ProfileImageEvent{
  GridElementChooseNO();
}