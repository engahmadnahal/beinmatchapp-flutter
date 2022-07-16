import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/LoggerHelper.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/model/club/club_model.dart';
import 'package:beinmatch/model/match/match_model.dart';
import 'package:beinmatch/model/news/news_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(InitState());
  static AppCubit get(context) => BlocProvider.of(context);

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
      try{emit(ErrorMainLayoutDrawerState());}catch(e){}

    }
  }

  /*
    Cubit For News  Page

  */

  List<Post> posts = [];
  List<Post> get getPosts {
    return this.posts;
  }


 /// Number of trying get data in api
  int counterErrorGetNews = 0;

  void getNews() async {
    emit(LoadingNewsState());
    posts.clear();
    counterErrorGetNews++;
    try {
      var response = await DioHelper.getData(url: 'posts');
      response!.data['data'].forEach((e) => {
        posts.add(Post.fromJson(e)),
      });
      emit(SuccessNewsState());
    } catch (e) {
      print(e);
      print("hear");
      if(e is DioError){
        print(e.toString());
      }
      if (counterErrorGetNews < 3) {
        getNews();
      } else {
        await LoggerHelper.saveLog(e.toString() + " - [Class - main/cubit] - [Method - getNews]");
        try{emit(ErrorNewsState());}catch(e){}
      }
    }
  }



  /// ------------------------------------------- {Controller For Get Club in Home Page News} -------------
  List<ClubModel> clubs = [];
  /// Number of trying get data in api
  int counterErrorGetClub = 0;

  void getClub() async {
    emit(LoadingGetClubState());
    counterErrorGetClub++;
    try {
      var response = await DioHelper.getData(url: 'clubs');
      response!.data['data'].forEach((e) => {
        clubs.add(ClubModel.fromJson(e)),
      });
      emit(SuccessGetClubState());
    } catch (e) {
      print(e);
      if (counterErrorGetClub < 3) {
        getClub();
      } else {
        await LoggerHelper.saveLog(e.toString() + " - [Class - main/cubit] - [Method - getClub]");
        try{emit(ErrorGetClubState());}catch(e){}

      }
    }
  }


  /// ------------------------------------------- {Controller For Get Matches in Home Page News} -------------
  List<MatchModel> matches = [];
  /// Number of trying get data in api
  int counterErrorGetMatch = 0;

  void getMatch() async {
    emit(LoadingGetMatchState());
    counterErrorGetMatch++;
    try {
      var response = await DioHelper.getData(url: 'mobara/today');
      response!.data['data'].forEach((e) => {
        matches.add(MatchModel.fromJson(e)),
      });
      emit(SuccessGetMatchState());
    } catch (e) {
      print(e);
      if (counterErrorGetMatch < 3) {
        getClub();
      } else {
        await LoggerHelper.saveLog(e.toString() + " - [Class - main/cubit] - [Method - getMatch]");
        try{emit(ErrorGetMatchState());}catch(e){}
      }
    }
  }

  /// ------------------------------------------- {Controller For Get Club in Home Page News of A Tab} -------------
  // List<ClubModel> clubsTab = [];
  // /// Number of trying get data in api
  // int counterErrorGetClubTab = 0;
  //
  // void getClubOfTab() async {
  //   emit(LoadingGetTabClubState());
  //   counterErrorGetClubTab++;
  //   try {
  //     var response = await DioHelper.getData(url: 'clubs');
  //     response!.data['data'].forEach((e) => {
  //       clubsTab.add(ClubModel.fromJson(e)),
  //     });
  //     emit(SuccessGetTabClubState());
  //   } catch (e) {
  //     print(e);
  //     if (counterErrorGetClubTab < 3) {
  //       getClub();
  //     } else {
  //       await LoggerHelper.saveLog(e.toString() + " - [Class - main/cubit] - [Method - getClubOfTab]");
  //       try{emit(ErrorGetTabClubState());}catch(e){}
  //     }
  //   }
  // }
}