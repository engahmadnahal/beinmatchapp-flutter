import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/LoggerHelper.dart';
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/controller/home/news/single/stats.dart';
import 'package:beinmatch/controller/home/news/stats.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/model/news/news_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleNewsCubit extends Cubit<SingleNewsState> {
  SingleNewsCubit() : super(InitSingleNewsStates());

  static SingleNewsCubit get(context) => BlocProvider.of(context);

  bool isOpenDrawer = false;
  double xOff = 0;
  double yOff = 0;
  double zOff = 0;

  void openDrawer(context) {
    emit(LoadingSingleNewsDrawerState());
    isOpenDrawer = !isOpenDrawer;
    try {
      if (isOpenDrawer) {
        xOff = -(MediaQuery
            .of(context)
            .size
            .width / 3) * 2;
        yOff = 0;
        zOff = 0;
      } else {
        xOff = 0;
        yOff = 0;
        zOff = 0;
      }
      emit(SuccessSingleNewsDrawerState());
    } catch (e) {
      emit(ErrorSingleNewsDrawerState());
    }
  }

  /*-------------------------------- {Start Rating} --------------------------------*/

  /// Varible For Like and DisLike
  int? countLike = null;
  int? countDisLike = null;
  int? statusUser = null;
  var colorBtn = Color(Config.unActiveColor);

  void sendLike(int? postId, int isLike) async {
    emit(SendLikeNewsState());
    int? tempIsActive = statusUser;
    try {
      /// Equle statusUser to parm isLike Because cond on fun isActive
      statusUser = isLike;
      // colorBtn = Color(Config.primaryColor);
      emit(LoadingLikeNewsState());
      var response = await DioHelper.postData(
        url: 'post/${postId}/like',
        data: {
          'is_like': isLike,
        },
      );
      getStatusLikeUser(isLike);
      countLike = response!.data['data']['likes'];
      countDisLike = response.data['data']['dislikes'];
      emit(SuccessLikeNewsState());
    } catch (e) {
      statusUser = tempIsActive;
      print(e.toString());
      try {
        emit(ErrorLikeNewsState());
      } catch (e) {}
    }
  }

  void getStatusLikeUser(int isLike) {
    statusUser = isLike;
    // try {
    //   emit(LoadingGetUserLikeNewsState());
    //   var response = await DioHelper.getData(url: 'post/${postId}/user-like');
    //   statusUser = response!.data['is_like'];
    //   print(response.data['is_like']);
    //   emit(SuccessGetUserLikeNewsState());
    // } catch (e) {
    //   print(e);
    //   try{
    //     emit(ErrorGetUserLikeNewsState());
    //   }catch(e){}
    // }
  }

  Color? isActive(String type) {
    if (statusUser == 1 && type == 'like') {
      return Color(Config.primaryColor);
    } else if (statusUser == 0 && type == 'dislike') {
      return Color(Config.primaryColor);
    }
    return null;
  }

/*-------------------------------- {Start Recommended Post} --------------------------------*/
  List<Post> recommendedPost = [];

  List<Post> get getRecomPost {
    return recommendedPost;
  }

  int counterErrorGetRecommendedNews = 3;

  void getRecommendedPost() async {
    emit(LoadingRecommNewsState());
    counterErrorGetRecommendedNews++;
    try {
      var response = await DioHelper.getData(url: 'posts/recommended');
      response!.data['data'].forEach((e) {
        recommendedPost.add(Post.fromJson(e));
      });
      emit(SuccessRecommNewsState());
    } catch (e) {
      if (counterErrorGetRecommendedNews < 3) {
        getRecommendedPost();
      } else {
        bool isSendLogger = await LoggerHelper.saveLog(e.toString() +
            " - [Class - single/cubit] - [Method - getRecommendedPost]");
      }
      emit(ErrorRecommNewsState());
    }
  }

/*-------------------------------- {Start Update Comment Post} --------------------------------*/
  Comment? commentPost;
  int countErrorUpdateComment = 0;

  void updateComment(int postId, int commendId, String commentUser) async {
    emit(LoadingUpdateCommentNewsState());
    countErrorUpdateComment++;
    try {
      var response = await DioHelper.postData(
          url: 'post/${postId}/comment/${commendId}/edit',
          data: {'comment': commentUser});

      Comment dataComment1 = Comment.fromJson(response!.data);
      commentPost = dataComment1;
      emit(SuccessUpdateCommentNewsState());
    } catch (e) {
      print(e.toString());
      if (countErrorUpdateComment < 3) {
        updateComment(postId, commendId, commentUser);
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - single/cubit] - [Method - updateComment]");
      }
      try {
        emit(ErrorUpdateCommentNewsState());
      } catch (e) {}
    }
  }

/*-------------------------------- {Start Send Comment Post} --------------------------------*/

  int countErrorSendComment = 0;

  Future<void> sendComment(int postId, String commentUser) async {
    emit(LoadingSendCommentNewsState());
    countErrorSendComment++;
    try {
      var response = await DioHelper.postData(
          url: 'post/${postId}/comment/send', data: {'comment': commentUser});
      Comment dataComment3 = Comment.fromJson(response!.data);
      commentPost = dataComment3;
      emit(SuccessSendCommentNewsState());
    } catch (e) {
      print(e.toString());
      if (countErrorSendComment < 3) {
        sendComment(postId, commentUser);
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - single/cubit] - [Method - sendComment]");
      }
      try {
        emit(ErrorSendCommentNewsState());
      } catch (e) {}
    }
  }

  int countErrorGetComment = 0;

  Future<void> getAllComment(int postId) async {
    emit(LoadingGetCommentNewsState());
    countErrorGetComment++;
    try {
      var response =
      await DioHelper.getData(url: 'post/${postId}/comments/show');
      Comment dataComment2 = Comment.fromJson(response!.data);
      commentPost = dataComment2;
      emit(SuccessGetCommentNewsState());
    } catch (e) {
      print(e.toString());
      if (countErrorGetComment < 3) {
        getAllComment;
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - single/cubit] - [Method - getAllComment]");
      }
      try {
        emit(ErrorGetCommentNewsState());
      } catch (e) {}
    }
  }

  int countErrorDeleteComment = 0;

  void deleteComment({context, int? postId, int? commentId}) async {
    countErrorDeleteComment++;
    try {
      emit(LoadingDeleteCommentNewsState());
      var response = await DioHelper.postData(
          url: 'post/comment/${commentId}/delete', data: {});
      getAllComment(postId!);
      Components.snakBar(
          context: context, color: Color(Config.primaryColor), text:response!.data['message']);
      emit(SuccessDeleteCommentNewsState());
    } catch (e) {
      if (countErrorDeleteComment < 3) {
        deleteComment(
            context: context,
            postId: postId,
            commentId: commentId
        );
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - single/cubit] - [Method - deleteComment]");
        try {
          emit(ErrorDeleteCommentNewsState());
        } catch (e) {}
      }
    }
  }
}
