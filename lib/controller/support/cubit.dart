import 'dart:convert';
import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/support/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Helpers/LoggerHelper.dart';


class SupportCubit extends Cubit<SupportState>{
  SupportCubit() : super(InitSupportState());

  static SupportCubit get(context) => BlocProvider.of(context);


  int coutnErrorSendMessage = 0;
  Future<void> sendMessage(String message) async{
    coutnErrorSendMessage++;
    try{
      emit(LoadingSupportState());
      var response = await DioHelper.postData(url: 'support', data: {
        'message' : message
      });
      emit(SuccessSupportState());
    }catch(e){
      if(coutnErrorSendMessage < 3){
        sendMessage(message);
      }
      try{
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/support/cubit] - [Method - sendMessage]");
        emit(ErrorSupportState());}catch(e){}
    }
  }


}