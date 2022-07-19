import 'dart:convert';
import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/setting/states.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Helpers/LoggerHelper.dart';
import '../../Helpers/sheard_prefrancess.dart';


class SettingCubit extends Cubit<SettingState>{
  SettingCubit() : super(InitSettingState());

  static SettingCubit get(context) => BlocProvider.of(context);

  late Map<String,dynamic> userInfo ;
  void startApp(){

    getDataUser();
  }

  void getDataUser(){
    emit(LoadingSettingState());
     userInfo = json.decode(SheardHelper.getData('userInfo')!);
    emit(SuccessSettingState());
  }


  int coutnErrorRemoveFav = 0;
  void removeAllFavorite(context) async{
    coutnErrorRemoveFav++;
    try{
      emit(LoadingRemoveFavoriteSettingState());
      var response = await DioHelper.postData(url: 'clubs/favorite/remove-all', data: {});
      Components.snakBar(context: context,
        text: "${response!.data['message']}",
        color: Color(Config.primaryColor)
      );
      emit(SuccessRemoveFavoriteSettingState());
    }catch(e){
      if(coutnErrorRemoveFav < 3){
        removeAllFavorite(context);
      }
      try{
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/setting/cubit] - [Method - removeAllFavorite]");
        emit(ErrorRemoveFavoriteSettingState());}catch(e){}
    }
  }


  void logOut(context) async{
    try{
      emit(LoadingSettingState());
      await SheardHelper.removeData('userInfo');
      Components.navigatorReplace(context: context, screen: AuthLogin());
      emit(SuccessSettingState());
    }catch(e){
      emit(ErrorSettingState());
    }
  }
}