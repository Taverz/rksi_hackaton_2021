import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class ProfileImageStates extends Equatable {
  ProfileImageStates([List props = const []]);
  //  : super(props);

    @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Success extends ProfileImageStates {
  Success();

  @override
  String toString() => 'AccomodationSuccess';

  // @override
  // // TODO: implement props
  // List<Object?> get props => throw UnimplementedError();
}

class OpenListPath extends ProfileImageStates {
  OpenListPath();

  @override
  String toString() => 'AccomodationSuccess';
  
  // @override
  // // TODO: implement props
  // List<Object?> get props => throw UnimplementedError();
}

class CloseListPath extends ProfileImageStates {
  List<AssetPathEntity>? listPath;
  int? index;
  CloseListPath({
    this.listPath,
    this.index
  });

  @override
  String toString() => 'AccomodationSuccess';
}

class ImageOpen extends ProfileImageStates {
  ImageOpen();

  @override
  String toString() => 'AccomodationSuccess';
}
class Chosen extends ProfileImageStates {
  int index; 
  Uint8List imageBytes;
  Chosen(this.imageBytes, this.index);

  @override
  String toString() => 'AccomodationSuccess';
}

// class Choose extends ProfileImageStates {
//   final bool choose;
//   Choose(this.choose);
  
//   @override
//   String toString() => 'AccomodationChoiceYes';
// }

class ChooseNo extends ProfileImageStates {
  ChooseNo();

  @override
  String toString() => 'AccomodationChoiceNo';
}

class Uninitialized extends ProfileImageStates {
  @override
  String toString() => 'AccomodationUninitialized';
}

class Error extends ProfileImageStates {

  Error(): super();

  @override
  String toString() => 'AccomodationError';
}