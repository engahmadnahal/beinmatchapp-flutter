import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/LoggerHelper.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/model/news/news_model.dart';
import 'package:bloc/bloc.dart';
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
      emit(ErrorMainLayoutDrawerState());
    }
  }

  /*
    Cubit For News  Page

  */

  List<Post> posts = [];
  List<Post> get getPosts {
    return this.posts;
  }

  /**
   * Number of trying get data in api
   */
  int counterErrorGetNews = 0;

  void getNews() async {
    emit(LoadingNewsState());
    counterErrorGetNews++;
    try {
      var response = await DioHelper.getData(url: 'posts');
      response!.data['data'].forEach((e) => {
        posts.add(Post.fromJson(e)),
      });
      emit(SuccessNewsState());
    } catch (e) {
      print(e);

      if (counterErrorGetNews < 3) {
        getNews();
      } else {
        bool isSendLogger = await LoggerHelper.saveLog(e.toString() + " - [Class - main/cubit] - [Method - getNews]");
        print(isSendLogger);
        emit(ErrorNewsState());
      }
    }
  }


}