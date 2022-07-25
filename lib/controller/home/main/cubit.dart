import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/LoggerHelper.dart';
import 'package:beinmatch/controller/home/main/stats.dart';
import 'package:beinmatch/model/news/news_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayoutCubit extends Cubit<MainLayoutStates> {
  MainLayoutCubit() : super(InitMainLayoutState());

  static MainLayoutCubit get(context) => BlocProvider.of(context);




// ----------------------------------------{ Drawer Setting }--------------------------------------

  /* 
    Cubit For Drawer Sidebar
  */
  bool isOpenDrawer = false;
  double xOff = 0;
  double yOff = 0;
  double zOff = 0;

  void openDrawer(context) {
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

// ----------------------------------------{ News Page }--------------------------------------

  /* 
    Cubit For News  Page 

  */

  // List<Post> posts = [];
  // List<Post> get getPosts {
  //   return this.posts;
  // }
  //
  // /**
  //  * Number of trying get data in api
  //  */
  // int counterErrorGetNews = 0;
  //
  // void getNews() async {
  //   emit(LoadingNewsState());
  //   counterErrorGetNews++;
  //   try {
  //     var response = await DioHelper.getData(url: 'posts');
  //     response!.data['data'].forEach((e) => {
  //           posts.add(Post.fromJson(e)),
  //         });
  //     emit(SuccessNewsState());
  //   } catch (e) {
  //     print(e.toString());
  //
  //     if (counterErrorGetNews < 3) {
  //       getNews();
  //     } else {
  //       LoggerHelper.saveLog(e);
  //       emit(ErrorNewsState());
  //     }
  //   }
  // }


}
