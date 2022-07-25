import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/club/states.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Helpers/DioHelper.dart';
import '../../Helpers/LoggerHelper.dart';
import '../../model/club/single_club_model.dart';

class ClubCubit extends Cubit<ClubState>  {
  ClubCubit() : super(InitClubState());
  static ClubCubit get(context) => BlocProvider.of(context);

  // ----------------------------------------{ Drawer Setting }--------------------------------------

  /*
    Cubit For Drawer Sidebar
  */
  bool isOpenDrawer = false;
  double xOff = 0;
  double yOff = 0;
  double zOff = 0;

  void openDrawer(context) {
    print('Comming Drawer');
    emit(LoadingMainLayoutDrawerState());
    isOpenDrawer = !isOpenDrawer;
    try {
      if (isOpenDrawer) {
        xOff = -(MediaQuery.of(context).size.width / 3) * 2;
        yOff = 0;
        zOff = 0;
      } else {
        xOff = 0;
        yOff = 0;
        zOff = 0;
      }
      emit(SuccessMainLayoutDrawerState());
    } catch (e) {
      emit(ErrorMainLayoutDrawerState());
    }
  }
  /// ------------------------ {Get Club Date } -------------------------
  bool isSuccess = false;
  int counterErrorGetClubData = 0;
   SingelClubModel? clubModel;
  void getSingleClubData(int clubId) async {
    counterErrorGetClubData++;
    emit(LoadingClubState());
    try{
      var response = await DioHelper.getData(url: 'clubs/${clubId}/show');
      clubModel = SingelClubModel.fromJson(response!.data['data']);
      isSuccess = true;
      emit(SuccessClubState());
    }catch(e){
      if(counterErrorGetClubData < 3){
        getSingleClubData(clubId);
      }else{
        print(e);
        isSuccess = false;
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/club/cubit] - [Method - getSingleClubData]");
      }
      try{emit(ErrorClubState());}catch(e){}
    }
  }

/// ------------------------ {checkFavorite} ----------------------------------
  int counterErrorcheckFavorite = 0;
  bool isFavorite = false;
  void checkFavorite(int clubId) async {
    counterErrorcheckFavorite++;
    emit(LoadingCheckFavoriteState());
    try{
      var response = await DioHelper.getData(url: 'clubs/${clubId}/favorite');
      isFavorite = response!.data['favorite'];
      emit(SuccessCheckFavoriteState());
    }catch(e){
      if(counterErrorcheckFavorite < 3){
        checkFavorite(clubId);
      }else{
        print(e);
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/club/cubit] - [Method - checkFavorite]");
      }
      try{emit(ErrorCheckFavoriteState());}catch(e){}
    }
  }
  /// ------------------------ {Send Favorite} ----------------------------------
  int counterErrorSendFavorite = 0;

  void sendFavorite(context,int clubId) async {
    counterErrorSendFavorite++;
    emit(LoadingSendFavoriteState());
    isFavorite = true;
    try{
      var response = await DioHelper.postData(url: 'clubs/favorite/create',
      data: {
        'club_id' : clubId
      });
      print("*******************");
      print(response!.data['message']);
      print("*******************");
      isFavorite = response.data['favorite'];

      emit(SuccessSendFavoriteState());
      Components.snakBar(context: context,
        text: isFavorite ? "تم الاضافة الى الفضلة" : 'تم الازالة من المفضلة',
        color: Color(Config.primaryColor)
      );
    }catch(e){
      if(counterErrorSendFavorite < 3){
        sendFavorite(context,clubId);
      }else{
        print(e);
        if(e is DioError){
          print(e.response!.data);
        }
        isFavorite = false;
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/club/cubit] - [Method - sendFavorite]");
      }
      Components.snakBar(context: context,
          text: 'حدث خطأ اثناء الاضافة',
          color: Color(Config.errorColor)
      );
      try{emit(ErrorSendFavoriteState());}catch(e){}
    }
  }
}