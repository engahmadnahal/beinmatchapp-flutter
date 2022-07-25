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

  int userCheckPoll = 0;

  void startApp(MatchModel match){
    userCheckPoll = match.poll_user_check!;
    sumPersantPoll(
      one: match.poll_to_club_one!,
      draw: match.poll_to_darw!,
      two: match.poll_to_club_two!
    );
    getAllComment(match.id!);
    getStatusLikeUser(match.user_like_check!);
    getVideo(match.channel!.channel_url!.urls![0]);
  }

  /// --------------------------------- Player Widget And Controller --------------------------------
  bool isReady = false;
  var playerWidget;
  /// [selectUrl] for check , and active button using toggle video url
  String selectUrl = "";
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  void getVideo(String url) async {
    selectUrl = url;
    bool isM3u8 = url.contains("m3u8");
    try{
      emit(LoadingVideoState());
      /// Set Init VideoPlayerController
      /// And Add UsePermisstion IN MinfestAndroid , Then Start in Android Api
       videoPlayerController = VideoPlayerController.network(url
          ,formatHint: isM3u8 ? VideoFormat.hls : VideoFormat.other)
      ..initialize().then((_) {
        print("Init Video ");
      });
      /// Player Controller for packge Chewie
       chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        showOptions: false,
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

  void changVideo(String url){
    disposePlayer();
    getVideo(url);
    emit(SuccessChangeVideoMatchState());
  }

  void disposePlayer(){
    videoPlayerController.dispose();
    chewieController.dispose();
  }
  /// This override method in state class BlocBase , we using close the player when exit user in screen
  @override
  Future<void> close() async {
    disposePlayer();
    super.close();
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

  /*-------------------------------- {Start Send Poll } --------------------------------*/

  int countErrorSendPoll = 0;

  Future<void> sendPoll(int matchId, {
    required bool one,
    required bool draw,
    required bool two,
}) async {
    /// Check and Change [userCheckPoll] when click user poll
    int tempUserCheckPoll = userCheckPoll;
    if(one){
      userCheckPoll = 1;
    }else if(draw){
      userCheckPoll = 2;
    }else if(two){
      userCheckPoll = 3;
    }

    emit(LoadingSendPollMatchState());
    countErrorSendPoll++;
    try {
      var response = await DioHelper.postData(
          url: 'mobara/${matchId}/poll', data: {
            'club_one': one ? 1 : 0,
            'darw' : draw? 1 : 0,
            'club_two' : two? 1 : 0
          });
      /// Get Response date from api and pass , to [sumPersantPoll] method
      Map<String,dynamic> dataResp = response!.data['data'];
      sumPersantPoll(one: dataResp['poll_to_club_one'], draw: dataResp['poll_to_darw'], two: dataResp['poll_to_club_two']);
      emit(SuccessSendPollMatchState());
    } catch (e) {
      userCheckPoll = tempUserCheckPoll;
      print(e.toString());
      if (countErrorSendPoll < 3) {
        sendPoll(matchId, one: one,draw: draw,two: draw);
      } else {
        await LoggerHelper.saveLog(e.toString() +
            " - [Class - video/cubit] - [Method - sendComment]");
      }
      try {
        emit(ErrorSendPollMatchState());
      } catch (e) {}
    }
  }

  Color colorPoll(String type){
    if(userCheckPoll == 1 && type == "one"){
      return Color(Config.primaryColor);
    }else if(userCheckPoll == 2 && type == "draw"){
      return Color(Config.primaryColor);
    }else if(userCheckPoll == 3 && type == "two"){
      return Color(Config.primaryColor);
    }
    return Color(Config.unActiveColor);
  }

  Color colorTextPoll(String type){
    if(userCheckPoll == 1 && type == "one"){
      return Colors.white;
    }else if(userCheckPoll == 2 && type == "draw"){
      return Colors.white;
    }else if(userCheckPoll == 3 && type == "two"){
      return Colors.white;
    }
    return Color(Config.primaryColor);
  }

/*-------------------------------- {Start Sum Poll & Persant } --------------------------------*/
  int numPollOnePersant = 0;
  int numPollDrawPersant = 0;
  int numPollTwoPersant = 0;

  void sumPersantPoll({
    required int one,
    required int draw,
    required int two,
  }){

    try{
      int sumAllPool = (one + two + draw);
      if(sumAllPool > 0){
        numPollOnePersant = (one ~/ sumAllPool).toInt() * 100 ;
        numPollDrawPersant = (draw ~/ sumAllPool ).toInt() * 100 ;
        numPollTwoPersant = (two ~/ sumAllPool).toInt() * 100 ;
      }

    }catch(e){}

  }

}