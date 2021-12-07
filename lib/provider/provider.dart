
import 'package:flutter/cupertino.dart';

class CarouselIndicator extends ChangeNotifier{

  int indexInd = 0;

  changeIndex(int index){
    indexInd = index;
    
    notifyListeners();
  }
}