import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/LoggerHelper.dart';
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/video/states.dart';
import 'package:beinmatch/model/match/match_model.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/src/chewie_player.dart';

class VideoCubit extends Cubit<VideoState>{
  VideoCubit() : super(InitVideoState());
  static VideoCubit get(context) => BlocProvider.of(context);


  /// --------------------------------- Player Widget And Controller --------------------------------
  bool isReady = false;
  var playerWidget;
  void getVideo(String urls) async {
    bool isM3u8 = urls.contains("m3u8");
    try{
      emit(LoadingVideoState());
      /// Set Init VideoPlayerController
      /// And Add UsePermisstion IN MinfestAndroid , Then Start in Android Api
      final VideoPlayerController videoPlayerController = VideoPlayerController.network('${urls}'
          ,formatHint: isM3u8 ? VideoFormat.hls : VideoFormat.other)
      ..initialize().then((_) {
        print("Init Video ");
      });
      /// Player Controller for packge Chewie
      ChewieController chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
      );

      /// Assign [playerWidget] Widget Chewie Player with Controller
      playerWidget = Chewie(
        controller: chewieController,
      );
      /// [isReady] is a varible check in state is success
      isReady = true;
      emit(SuccessVideoState());
    }catch(e){
      print(e);
      emit(ErrorVideoState());
      isReady = false;
    }

  }

  /*-------------------------------- {Start Check User isLike OR Not } --------------------------------*/

  /// [statusUser] is a variable control in the state active button like or not when click or get server side
  int? statusUser = null;
  /// [colorBtn] is a variable control a color button like active , when [statusUser] equal true
  var colorBtn = Color(Config.unActiveColor);

  void sendLike(int? matchId, int isLike) async {
    emit(SendLikeMatchState());
    int? tempIsActive = statusUser;
    try {
      /// Equle statusUser to parm isLike Because cond on fun isActive
      statusUser = isLike;
      // colorBtn = Color(Config.primaryColor);
      emit(LoadingLikeMatchState());
      var response = await DioHelper.postData(
        url: 'mobara/${matchId}/like',
        data: {
          'is_like': isLike,
        },
      );
      getStatusLikeUser(isLike);
      emit(SuccessLikeMatchState());
    } catch (e) {
      statusUser = tempIsActive;
      print(e.toString());
      try {
        emit(ErrorLikeMatchState());
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

  /*-------------------------------- {Start Update Comment } --------------------------------*/
  Comments? commentMatch;
  int countErrorUpdateComment = 0;

  void updateComment(int matchId, int commendId, String commentUser) async {
    emit(LoadingUpdateCommentMatchState());
    countErrorUpdateComment++;
    try {
      var response = await DioHelper.postData(
          url: 'mobara/${matchId}/comment/${commendId}/edit',
          data: {'comment': commentUser});

      Comments dataComment1 = Comments.fromJson(response!.data);
      commentMatch = dataComment1;
      emit(SuccessUpdateCommentMatchState());
    } catch (e) {
      print(e.toString());
      if(e is DioError){
        print(e.response!.data);
      }
      if (countErrorUpdateComment < 3) {
        updateComment(matchId, commendId, commentUser);
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - video/cubit] - [Method - updateComment]");
      }
      try {
        emit(ErrorUpdateCommentMatchState());
      } catch (e) {}
    }
  }

/*-------------------------------- {Start Send Comment } --------------------------------*/

  int countErrorSendComment = 0;

  Future<void> sendComment(int matchId, String commentUser) async {
    emit(LoadingSendCommentMatchState());
    countErrorSendComment++;
    try {
      var response = await DioHelper.postData(
          url: 'mobara/${matchId}/comment', data: {'comment': commentUser});
      Comments dataComment3 = Comments.fromJson(response!.data);
      commentMatch = dataComment3;
      emit(SuccessSendCommentMatchState());
    } catch (e) {
      print(e.toString());
      if (countErrorSendComment < 3) {
        sendComment(matchId, commentUser);
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - video/cubit] - [Method - sendComment]");
      }
      try {
        emit(ErrorSendCommentMatchState());
      } catch (e) {}
    }
  }

/*-------------------------------- {Start Get Comment } --------------------------------*/

  int countErrorGetComment = 0;

  Future<void> getAllComment(int matchId) async {
    emit(LoadingGetCommentMatchState());
    countErrorGetComment++;
    try {
      var response =
      await DioHelper.getData(url: 'mobara/${matchId}/comments');
      Comments dataComment2 = Comments.fromJson(response!.data);
      commentMatch = dataComment2;
      emit(SuccessGetCommentMatchState());
    } catch (e) {
      print(e.toString());
      if (countErrorGetComment < 3) {
        getAllComment(matchId);
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - video/cubit] - [Method - getAllComment]");
      }
      try {
        emit(ErrorGetCommentMatchState());
      } catch (e) {}
    }
  }

/*-------------------------------- {Start Delete Comment } --------------------------------*/

  int countErrorDeleteComment = 0;

  void deleteComment({context, int? matchId, int? commentId}) async {
    countErrorDeleteComment++;
    try {
      emit(LoadingDeleteCommentMatchState());
      var response = await DioHelper.postData(
          url: 'mobara/comment/${matchId}/delete', data: {});
      getAllComment(matchId!);
      Components.snakBar(
          context: context, color: Color(Config.primaryColor), text:response!.data['message']);
      emit(SuccessDeleteCommentMatchState());
    } catch (e) {
      if (countErrorDeleteComment < 3) {
        deleteComment(
            context: context,
            matchId: matchId,
            commentId: commentId
        );
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - single/cubit] - [Method - deleteComment]");
        try {
          emit(ErrorDeleteCommentMatchState());
        } catch (e) {}
      }
    }
  }
}