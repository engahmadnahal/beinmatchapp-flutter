import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/controller/auth/login/states.dart';
import 'package:beinmatch/controller/auth/signup/states.dart';
import 'package:beinmatch/view/home/test.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  void signUp(context, var formKey, String fname,String lname, String email, String password) async {
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
          url: 'user/signup',
          data: {
            'fname': fname,
            'lname':lname,
            'email': email,
            'password': password,
          },
        );
        await SheardHelper.setData('token', response!.data['data']['token']);
        formKey.currentState.save();
        Components.navigator(context: context, screen: Home());
        emit(SignUpSuccess());

        /**
         * If The User Not Exist, We Can Show Error Message On Catch Error 
         * Because The Error Is From Api Call Http Requset [400] Bad Request
         */
      } catch (e) {
        if (e is DioError) {
          print(e.response!.data['errors']['email'][0]);
          if(e.response!.data['errors']['email'] != null){
            /**
             * If The Email Error is orady is exists
             */
            Components.snakBar(
                context: context,
                text: e.response!.data['errors']['email'][0],
                color: Color(Config.errorColor));
          }else{
            /**
             * Show Message Any Error Api Call
             */
          Components.snakBar(
              context: context,
              text: e.response!.data['message'],
              color: Color(Config.errorColor));
          }
          emit(SignUpError());
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
      emit(SignUpError());
    }
  }

}
