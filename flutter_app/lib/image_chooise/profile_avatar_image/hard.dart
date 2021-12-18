








import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_editor/src/image_source.dart';
import 'package:image_editor/src/utils/convert_utils.dart';
import 'dart:math' as math;
import 'package:image_editor/src/output_format.dart';
// import '../output_format.dart';

// part 'flip.dart';

// part 'clip.dart';

// part 'rotate.dart';

// part 'color.dart';

// part 'scale.dart';

// part 'add_text.dart';

// part 'mix_image.dart';

// part 'draw.dart';



import 'dart:typed_data';

class NativeChannel {
  static const MethodChannel _channel =
      const MethodChannel('top.kikt/flutter_image_editor');

  static MethodChannel get channel => _channel;

  static Future<Directory> getCachePath() async {
    final path = await _channel.invokeMethod("getCachePath");
    return Directory(path);
  }


static Future<Uint8List> memoryToMemory(
      Uint8List memory, ImageEditorOption option) async {
    if (option.options.isEmpty || option.canIgnore) {
      return memory;
    }

    final result = await _channel.invokeMethod("memoryToMemory", {
      "image": memory,
      "options": option.toJson(),
      "fmt": option.outputFormat.toJson(),
    });
    return result;
  }

}


// NativeChannel.memoryToMemory(_memory!, option);


  // static
   Future<File> editImageAndGetFile({
    required Uint8List image,
    required ImageEditorOption imageEditorOption,
  }) async {
    Uint8List? tmp = image;

    for (final group in imageEditorOption.groupList) {
      if (group.canIgnore) {
        continue;
      }
      // final handler = ImageHandler.memory(tmp);
      final editOption = ImageEditorOption();
      for (final option in group) {
        editOption.addOption(option);
      }

      editOption.outputFormat = imageEditorOption.outputFormat;

      // tmp = await handler.handleAndGetUint8List(editOption);
      tmp =await NativeChannel.memoryToMemory(tmp!, editOption);
    }

    final file = File(await _createTmpFilePath());

    if (tmp != null) {
      await file.writeAsBytes(tmp);
    }

    return file;
  }

    Future<Uint8List?> editImage({
    required Uint8List image,
    required ImageEditorOption imageEditorOption,
  }) async {
    Uint8List? tmp = image;
    for (final group in imageEditorOption.groupList) {
      if (group.canIgnore) {
        continue;
      }
      // final handler = ImageHandler.memory(tmp);
      final editOption = ImageEditorOption();
      for (final option in group) {
        editOption.addOption(option);
      }
      editOption.outputFormat = imageEditorOption.outputFormat;

      // tmp = await handler.handleAndGetUint8List(editOption);
      tmp =await NativeChannel.memoryToMemory(tmp!, editOption);
    }

    return tmp;
  }

  // static 
  Future<String> _createTmpFilePath() async {
    final cacheDir = await NativeChannel.getCachePath();
    final name = DateTime.now().millisecondsSinceEpoch;
    return "${cacheDir.path}/$name";
  }


abstract class IgnoreAble {
  bool get canIgnore;
}

abstract class TransferValue implements IgnoreAble {
  String get key;

  Map<String, Object> get transferValue;
}

abstract class Option implements IgnoreAble, TransferValue {
  const Option();
}

class ImageEditorOption implements IgnoreAble {
  ImageEditorOption();

  OutputFormat outputFormat = OutputFormat.jpeg(95);

  List<Option> get options {
    List<Option> result = [];
    for (final group in groupList) {
      for (final opt in group) {
        result.add(opt);
      }
    }
    return result;
  }

  List<OptionGroup> groupList = [];

  void reset() {
    groupList.clear();
  }

  void addOption(Option option, {bool newGroup = false}) {
    OptionGroup group;
    if (groupList.isEmpty || newGroup) {
      group = OptionGroup();
      groupList.add(group);
    } else {
      group = groupList.last;
    }

    group.addOption(option);
  }

  void addOptions(List<Option> options, {bool newGroup = true}) {
    OptionGroup group;
    if (groupList.isEmpty || newGroup) {
      group = OptionGroup();
      groupList.add(group);
    } else {
      group = groupList.last;
    }

    group.addOptions(options);
  }

  List<Map<String, Object>> toJson() {
    List<Map<String, Object>> result = [];
    for (final option in options) {
      if (option.canIgnore) {
        continue;
      }
      result.add({
        "type": option.key,
        "value": option.transferValue,
      });
    }
    return result;
  }

  @override
  bool get canIgnore {
    for (final opt in options) {
      if (!opt.canIgnore) {
        return false;
      }
    }
    return true;
  }

  String toString() {
    final m = <String, dynamic>{};
    m['options'] = toJson();
    m['fmt'] = outputFormat.toJson();
    return JsonEncoder.withIndent('  ').convert(m);
  }
}

class OptionGroup extends ListBase<Option> implements IgnoreAble {
  @override
  bool get canIgnore {
    for (final option in options) {
      if (!option.canIgnore) {
        return false;
      }
    }
    return true;
  }

  final List<Option> options = [];

  void addOptions(List<Option> optionList) {
    this.options.addAll(optionList);
  }

  void addOption(Option option) {
    this.options.add(option);
  }

  @override
  int get length => options.length;

  @override
  operator [](int index) {
    return options[index];
  }

  @override
  void operator []=(int index, value) {
    options[index] = value;
  }

  @override
  set length(int newLength) {
    options.length = newLength;
  }
}



//////////////////////////////////////////////////////////




class ClipOption implements Option {
  final num x;
  final num y;
  final num width;
  final num height;

  ClipOption({
    this.x = 0,
    this.y = 0,
    required this.width,
    required this.height,
  })   : assert(width > 0 && height > 0),
        assert(x >= 0, y >= 0);

  factory ClipOption.fromRect(Rect rect) {
    return ClipOption(
      x: fixNumber(rect.left),
      y: fixNumber(rect.top),
      width: fixNumber(rect.width),
      height: fixNumber(rect.height),
    );
  }

  factory ClipOption.fromOffset(Offset start, Offset end) {
    return ClipOption(
      x: fixNumber(start.dx),
      y: fixNumber(start.dy),
      width: fixNumber(end.dx - start.dx),
      height: fixNumber(end.dy - start.dy),
    );
  }

  static int fixNumber(num number) {
    return number.round();
  }

  @override
  String get key => "clip";

  @override
  Map<String, Object> get transferValue => {
        "x": x.round(),
        "y": y.round(),
        "width": width.round(),
        "height": height.round(),
      };

  @override
  bool get canIgnore => width <= 0 || height <= 0;
}



class RotateOption implements Option {
  final int degree;

  RotateOption(this.degree);

  RotateOption.radian(double radian)
      : degree = (radian / math.pi * 180).toInt();

  @override
  String get key => "rotate";

  @override
  Map<String, Object> get transferValue => {
        "degree": degree,
      };

  @override
  bool get canIgnore => degree % 360 == 0;
}
