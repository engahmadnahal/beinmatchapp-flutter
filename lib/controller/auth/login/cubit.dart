import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/controller/auth/login/states.dart';
import 'package:beinmatch/view/home/home_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login(context, var formKey, String email, String password) async {
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
        var response = await DioHelper.postData(
          url: 'user/login',
          data: {
            'email': email,
            'password': password,
          },
        );
        await SheardHelper.setData('token', response!.data['data']['token']);
        formKey.currentState.save();
        Components.navigator(context: context, screen: Home());
        emit(LoginSuccess());

        /**
         * If The User Not Exist, We Can Show Error Message On Catch Error 
         * Because The Error Is From Api Call Http Requset [400] Bad Request
         */
      } catch (e) {
        if (e is DioError) {
          Components.snakBar(
              context: context,
              text: "البريد او كلمة المرور خاطئة",
              color: Color(Config.errorColor));
          emit(LoginError());
        } else {
          /**
           * If The Error Is Not From Api Call Http Requset [400] Bad Request
           * Send For Error Message To Api Log System
           */
          try {
            DioHelper.postData(url: 'log', data: {'body': e});
          } catch (er) {}
        }
      }
    } else {
      /**
       * If The Form Is Not Valid, We Can Show Error Message Under Lable
       */
      emit(LoginError());
    }
  }

}
