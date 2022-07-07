import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/home/main/stats.dart';
import 'package:beinmatch/model/news/news_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
  //       emit(ErrorNewsState());
  //     }
  //     // getNews();
  //   }
  // }

  /* 
    Cubit For Single News  Page 
  */
//
// // ----------------------------------------{ Single News Page }--------------------------------------
//
//   /*
//     Varible For Like and DisLike
//  */
//   int? countLike = null;
//   int? countDisLike = null;
//   bool? statusUser = null;
//   var colorBtn = Color(Config.unActiveColor);
//
//   void sendLike(int? postId, bool isLike) async {
//     emit(SendLikeNewsState());
//     bool? tempIsActive = statusUser;
//     try {
//       // Equle statusUser to parm isLike Because cond on fun isActive
//       statusUser = isLike;
//       // colorBtn = Color(Config.primaryColor);
//       emit(LoadingLikeNewsState());
//       var response = await DioHelper.postData(
//         url: 'post/${postId}/like',
//         data: {
//           'is_like': isLike,
//         },
//       );
//       await getStatusLikeUser(postId);
//       countLike = response!.data['data']['likes'];
//       countDisLike = response.data['data']['dislikes'];
//       print(response.data);
//       emit(SuccessLikeNewsState());
//     } catch (e) {
//       statusUser = tempIsActive;
//       print(e.toString());
//       emit(ErrorLikeNewsState());
//     }
//   }
//
//   Future<void> getStatusLikeUser(int? postId) async {
//     try {
//       emit(LoadingGetUserLikeNewsState());
//       var response = await DioHelper.getData(url: 'post/${postId}/user-like');
//       statusUser = response!.data['is_like'];
//       print(response.data['is_like']);
//       emit(SuccessGetUserLikeNewsState());
//     } catch (e) {
//       print(e);
//       try {
//         emit(ErrorGetUserLikeNewsState());
//       } catch (e) {}
//     }
//   }

  // Color? isActive(String type) {
  //   if (statusUser == true && type == 'like') {
  //     return Color(Config.primaryColor);
  //   } else if (statusUser == false && type == 'dislike') {
  //     return Color(Config.primaryColor);
  //   }
  //   return null;
  // }

}
