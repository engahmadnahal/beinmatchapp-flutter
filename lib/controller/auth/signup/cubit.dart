import 'dart:convert';

import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/LoggerHelper.dart';
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/controller/auth/login/states.dart';
import 'package:beinmatch/controller/auth/signup/states.dart';
import 'package:beinmatch/view/home/home_screen.dart';
import 'package:beinmatch/view/main/main_layout.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  void signUp(context, var formKey, String fname,String lname, String email, String password,String osMobile) async {
    emit(SignUpLoading());
    /**
     * Validate TextFields 
     * In FormKey, we can get the current state of the form
     * and check if the form is valid or not
     * 
     */
    if (formKey.currentState.validate()) {
      /**
       * If the form is valid, we can check data base if the user exist
       * In Api Call, we can check if the user exist or not
       */
      try {
        /**
         * Send Data For Api And Check If The User Exist
         */
        var response = await DioHelper.postDataWithOutToken(
          url: 'user/signup',
          data: {
            'fname': fname,
            'lname':lname,
            'email': email,
            'password': password,
            'os_mobile' : osMobile
          },
        );
        /// Store Map<> For All User Data , using [Json encode]
        String data = json.encode(response!.data['data']);
        await SheardHelper.setData('userInfo', data);

        formKey.currentState.save();

        /// Get Setting App
        var responseSetting = await DioHelper.getData(url: 'setting');
        String dataSetting = json.encode(responseSetting!.data);
        await SheardHelper.setData('setting', dataSetting);
        Navigator.pushReplacement(context, MaterialPageRoute(builder:  (contenxt)=>MainLayout()));
        // Components.navigatorReplace(context: context, screen: MainLayout());
        emit(SignUpSuccess());
        /**
         * If The User Not Exist, We Can Show Error Message On Catch Error 
         * Because The Error Is From Api Call Http Requset [400] Bad Request
         */
      } catch (e) {
        if (e is DioError) {
          print(e.message);
            /**
             * If The Email Error is orady is exists
             */
            Components.snakBar(
                context: context,
                text: e.response!.data['message'],
                color: Color(Config.errorColor));
          emit(SignUpError());
        } else {
          /**
           * If The Error Is Not From Api Call Http Requset [400] Bad Request
           * Send For Error Message To Api Log System
           */
          try {
            await LoggerHelper.saveLog(e.toString());
          } catch (er) {}
        }
      }
    } else {
      /**
       * If The Form Is Not Valid, We Can Show Error Message Under Lable
       */
      emit(SignUpError());
    }
  }

}
