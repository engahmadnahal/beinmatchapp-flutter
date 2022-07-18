import 'dart:convert';
import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/controller/setting/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Helpers/sheard_prefrancess.dart';


class SettingCubit extends Cubit<SettingState>{
  SettingCubit() : super(InitSettingState());

  static SettingCubit get(context) => BlocProvider.of(context);

  late Map<String,dynamic> userInfo ;
  bool isDark = SheardHelper.getBool('mode')??false;
  void startApp(){
    getDataUser();
  }
  /// -------------------- {Start Get Data user } --------------------------

  void getDataUser(){
    emit(LoadingSettingState());
     userInfo = json.decode(SheardHelper.getData('userInfo')!);
    emit(SuccessSettingState());
  }

  /// -------------------- {Start Remove all favorite } --------------------------
  int counterErrorRemoveFav = 0;
  void removeAllFavorite() async {
    counterErrorRemoveFav++;
    emit(LoadingRemoveFavoriteSettingState());
    try{
      var response = await DioHelper.postData(url: 'clubs/favorite/remove-all', data: {});
      print("======================");
      print(response!.data);
      print("======================");
      emit(SuccessRemoveFavoriteSettingState());
    }catch(e){
      if(counterErrorRemoveFav < 3){
        removeAllFavorite();
      }
      try{emit(ErrorRemoveFavoriteSettingState());}catch(e){}
    }
  }

  /// -------------------- {Start Active Mode app } --------------------------
  void modeApp()async{
    emit(LoadingModeSettingState());
    isDark = !isDark;
    try{
      await SheardHelper.setBool('mode', true);
    }catch(e){
      isDark = false;
      try{emit(ErrorModeSettingState());}catch(e){};
    }
  }

}