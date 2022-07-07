// import 'package:beinmatch/Helpers/DioHelper.dart';
// import 'package:beinmatch/Helpers/components/components.dart';
// import 'package:beinmatch/Helpers/config.dart';
// import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
// import 'package:beinmatch/controller/home/news/single/stats.dart';
// import 'package:beinmatch/controller/home/news/stats.dart';
// import 'package:beinmatch/model/news/news_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SingleNewsCubit extends Cubit<SingleNewsState> {
//   SingleNewsCubit() : super(InitSingleNewsStates());
//   static SingleNewsCubit get(context) => BlocProvider.of(context);

// /**
//  * Varible For Like and DisLike
//  */
//   int? countLike = null;
//   int? countDisLike = null;
//   bool? statusUser = null;
//   var colorBtn = Color(Config.unActiveColor);


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

//   Future<void> getStatusLikeUser(int? postId) async {
//     try {
//       emit(LoadingGetUserLikeNewsState());
//       var response = await DioHelper.getData(url: 'post/${postId}/user-like');
//       statusUser = response!.data['is_like'];
//       print(response.data['is_like']);
//       emit(SuccessGetUserLikeNewsState());
//     } catch (e) {
//       print(e);
//       try{
//         emit(ErrorGetUserLikeNewsState());
//       }catch(e){}
//     }
//   }

//   Color? isActive(String type) {
//     if (statusUser == true && type == 'like' ) {
//       return Color(Config.primaryColor);
//     } else if(statusUser == false && type == 'dislike'){
//       return Color(Config.primaryColor);
//     }
//       return null;
//   }

// }
