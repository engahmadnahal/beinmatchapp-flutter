import 'dart:convert';
import 'package:beinmatch/controller/setting/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Helpers/sheard_prefrancess.dart';


class SettingCubit extends Cubit<SettingState>{
  SettingCubit() : super(InitSettingState());

  static SettingCubit get(context) => BlocProvider.of(context);

  late Map<String,dynamic> userInfo ;
  void startApp(){
    getDataUser();
  }

  void getDataUser(){
    emit(LoadingSettingState());
     userInfo = json.decode(SheardHelper.getData('userInfo')!);
    emit(SuccessSettingState());
  }

  void removeAllFavorite(){

  }
}