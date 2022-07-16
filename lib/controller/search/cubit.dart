import 'package:beinmatch/controller/search/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Helpers/DioHelper.dart';
import '../../Helpers/LoggerHelper.dart';
import '../../model/club/club_model.dart';
import '../../model/news/news_model.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(InitSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  void startApp(){
    getClub();
    getNews();
  }

  /// ------------------------------------------- {Controller For Get Club in Search Page} -------------
  List<ClubModel> clubs = [];
  /// Number of trying get data in api
  int counterErrorGetClub = 0;

  void getClub() async {
    emit(LoadingSearchState());
    counterErrorGetClub++;
    try {
      var response = await DioHelper.getData(url: 'clubs');
      response!.data['data'].forEach((e) => {
        clubs.add(ClubModel.fromJson(e)),
      });
      emit(SuccessGetClubSearchState());
    } catch (e) {
      print(e);
      if (counterErrorGetClub < 3) {
        getClub();
      } else {
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/search/cubit] - [Method - getClub]");
        try{emit(ErrorGetClubSearchState());}catch(e){}

      }
    }
  }

  /// ------------------------------------------- {Controller For Get News in Search Page } -------------

  List<Post> posts = [];



  /// Number of trying get data in api
  int counterErrorGetNews = 0;

  void getNews() async {
    emit(LoadingSearchState());
    posts.clear();
    counterErrorGetNews++;
    try {
      var response = await DioHelper.getData(url: 'posts');
      response!.data['data'].forEach((e) => {
        posts.add(Post.fromJson(e)),
      });
      emit(SuccessGetNewsSearchState());
    } catch (e) {
      print(e);
      print("hear");
      if(e is DioError){
        print(e.toString());
      }
      if (counterErrorGetNews < 3) {
        getNews();
      } else {
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/search/cubit] - [Method - getNews]");
        try{emit(ErrorGetNewsSearchState());}catch(e){}
      }
    }
  }

/// ------------------------------------------- {Controller For Search in Search Page } -------------
  /// This Lists is a temp value for other list , when user clear input search , return temp list
  List<ClubModel> clubsTemp = [];
  List<Post> postsTemp = [];

  int counterErrorSearch = 0;
  bool tempListFull = false;

  void getSearch(String serchText) async {

    emit(LoadingSearchState());
    if(!tempListFull){
      print("tempListFull");
      tempListFull = true;
      postsTemp.addAll(posts);
      clubsTemp.addAll(clubs);
    }
    /// This Lists is a temp value for other list , when user clear input search , return temp list
    if(serchText == "empty"){
      print("tempListFull Trueeeeeeee");

      /// clear a list
      posts.clear();
      clubs.clear();
      /// add a tempList in a list
      posts.addAll(postsTemp);
      clubs.addAll(clubsTemp);
      emit(SuccessSearchState());
      return;
    }

    counterErrorSearch++;
    try {
      var response = await DioHelper.postData(url: 'search', data: {
        'search' : serchText,
        'status' : 'success'
      });
      /// Save response [post] in a list [posts]
      posts.clear();
      clubs.clear();

      response!.data['data']['posts'].forEach((e) => {
        posts.add(Post.fromJson(e)),
      });
      /// Save response [club] in a list [clubs]
      response.data['data']['clubs'].forEach((e) => {
        clubs.add(ClubModel.fromJson(e)),
      });
      emit(SuccessSearchState());
    } catch (e) {
      print(e);
      if(e is DioError){
        print(e.toString());
      }
      if (counterErrorSearch < 3) {
        getSearch(serchText);
      } else {
        await LoggerHelper.saveLog(e.toString() + " - [Class - controller/search/cubit] - [Method - getNews]");
        try{
          /// Save Searching user in data base with error states
          await DioHelper.postData(url: 'search', data: {
            'search' : serchText,
            'status' : 'error'
          });
          emit(ErrorSearchState());
        }catch(e){}
      }
    }
  }

}