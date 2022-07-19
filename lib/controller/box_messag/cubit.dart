import 'dart:convert';
import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/box_messag/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Helpers/LoggerHelper.dart';
import '../../model/notification/notification.dart';


class BoxMsgCubit extends Cubit<BoxMsgState>{
  BoxMsgCubit() : super(InitBoxMsgState());

  static BoxMsgCubit get(context) => BlocProvider.of(context);


  void startApp(){
    getAllMsg();
    Future.delayed(Duration(seconds: 2), () =>readAllMsg());
  }


  int countErrorGetBxMsg = 0;
  late NotifictionModel notifictionModel;
  bool isReady = false;
  void getAllMsg() async {
    countErrorGetBxMsg++;
    try{
      emit(LoadingBoxMsgState());
      var response = await DioHelper.getData(url: 'notification');
      print(response!.data);
      notifictionModel = NotifictionModel.formJson(response.data['data']);
      emit(SuccessBoxMsgState());
      isReady = true;
    }catch(e){
      if(countErrorGetBxMsg < 3){
        getAllMsg();
      }
      try{
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/box_msg/cubit] - [Method - getAllMsg]");
        emit(ErrorBoxMsgState());}catch(e){}
    }
  }


  int countErrorrealAllMsg = 0;
  void readAllMsg() async {
    countErrorrealAllMsg++;
    try{
      emit(LoadingReadBoxMsgState());
      var response = await DioHelper.postData(url: 'notification/read',data : {});
      print(response!.data);
      emit(SucessReadBoxMsgState());
    }catch(e){
      if(countErrorrealAllMsg < 3){
        readAllMsg();
      }
      try{
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/box_msg/cubit] - [Method - realAllMsg]");
        emit(ErrorReadBoxMsgState());}catch(e){}
    }
  }

}