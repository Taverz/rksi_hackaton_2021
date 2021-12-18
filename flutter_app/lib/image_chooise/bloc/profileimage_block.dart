
import 'dart:typed_data';



import 'package:flutter_bloc/flutter_bloc.dart';

import './profileimage_event.dart';
import './profileimage_state.dart';

import 'package:flutter/cupertino.dart';





class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageStates> {


  ProfileImageBloc(ProfileImageStates initialState) : super(initialState);


  // void choiseElement(bool choise, int index){
  //     // if(choise){
  //       // add(GridElementChoose(index));
  //     // }
  // }
  

  @override
  ProfileImageStates get initialState => Uninitialized();

  @override
  Stream<ProfileImageStates> mapEventToState(ProfileImageEvent event) async* {
    try{
      if(event is GridElementChoose){
       yield  Chosen(event.bytes ,event.index);      
      } else if(event is OpenEvent){
        yield  OpenListPath();  
      }else if(event is CloseEvent){
        yield  CloseListPath();  
      }else if(event is ListPathChoise){
        yield  CloseListPath(index: event.index , listPath: event.pathList , );  
      }else if(event is GridElementChooseNO){
        yield  ChooseNo();  
      }
      
      
      // switch (event.runtimeType) {

      //   case ListPathChoise:
      //     // RoomApi.changeSettle();
      //     //Close PathList, GridView изменить
      //     // yield ;
      //     break;
      //   case CloseEvent:
      //     yield CloseListPath();
      //     break;
      //   case OpenEvent:
      //     yield OpenListPath();
      //     break;
        
      //   case GridElementChoose:
      //     yield Chosen(event.); //state.model
      //     break;
        
          
       
      // }
    }
    catch (e) {
      yield Error();
    }
  }

}