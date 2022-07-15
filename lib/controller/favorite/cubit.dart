import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/favorite/states.dart';
import 'package:beinmatch/model/club/club_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Helpers/DioHelper.dart';
import '../../Helpers/LoggerHelper.dart';
/// This is State And Screen is Not Ready Use
///
///
///
///
///
///
///
///
///
///
///
/// Cancel This Screen And Remove in UI
class FavoriteCubit extends Cubit<FavoriteState>  {
  FavoriteCubit() : super(InitFavoriteState());
  static FavoriteCubit get(context) => BlocProvider.of(context);


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
  /// ---------------------------- {Get Date Club } ---------------------
  int counterErrorGetClubData = 0;
  List<ClubModel> clubs = [];
  void getAllClubs() async {
    counterErrorGetClubData++;
    emit(LoadingClubFavoriteState());
    try{
      var response = await DioHelper.getData(url: 'clubs/favorite');
      response!.data['data'][0]['clubs'].forEach((e) => {
        clubs.add(ClubModel.fromJson(e)),
      });
      print(response.data['data'][0]['clubs']);
      emit(SuccessClubFavoriteState());
    }catch(e){
      if(e is DioError){
        print(e.response!.data);
        print(e.toString());
      }
      if(counterErrorGetClubData < 3){
        getAllClubs();
      }else{
        print(e);
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/favorite/cubit] - [Method - getAllClubs]");
      }
      try{emit(ErrorClubFavoriteState());}catch(e){}
    }
  }

  int counterErrorRemoveClubFavorite = 0;

  void sendFavorite(context,int clubId) async {
    counterErrorRemoveClubFavorite++;
    emit(LoadingSendFavoriteState());
    try{
      var response = await DioHelper.postData(url: 'clubs/favorite/create',
          data: {
            'club_id' : clubId
          });

      clubs.removeWhere((element) => element.id == clubId);
      emit(SuccessSendFavoriteState());
      Components.snakBar(context: context,
          text:  'تم الازالة من المفضلة',
          color: Color(Config.primaryColor)
      );
    }catch(e){
      if(counterErrorRemoveClubFavorite < 3){
        sendFavorite(context,clubId);
      }else{
        print(e);
        if(e is DioError){
          print(e.response!.data);
        }
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/favorite/cubit] - [Method - sendFavorite]");
      }
      try{
      Components.snakBar(context: context,
          text: 'حدث خطأ اثناء الازالة',
          color: Color(Config.errorColor)
      );
      emit(ErrorSendFavoriteState());}catch(e){}
    }
  }



}