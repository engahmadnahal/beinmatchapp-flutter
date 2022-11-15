import 'dart:convert';

import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/**
 * ----------------------------------------------------------------
 * 
 * Created A Helper Class to handle all the Dio Requests
 * Using a singleton pattern to make sure that only one instance of Dio is created
 * -----------------------------------------------------------------
 */
class DioHelper {
  static Map<String,dynamic> userInfo = json.decode(SheardHelper.getData('userInfo')!);
  static Dio? dio;
  static String urlApi = Config.api_url;
  static bool _connection = false;
  static BaseOptions options = BaseOptions(
    baseUrl: urlApi,
    connectTimeout: 50000,
    receiveTimeout: 30000,
    receiveDataWhenStatusError: true
  );


  static instanc() async {
    dio ??= Dio(options);
    return dio;
  }

  static Future<bool> checkConnection() async {
    var result = await InternetConnectionChecker().hasConnection;
    return result;
  }


static Future<Response>? getDataWithoutToken({
    @required String? url,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
    };
    bool rConn = await checkConnection();
    if(rConn){
      return await dio!.get(url!);
    }
    throw new UnsupportedError("Connection Internet is invalid");
  }


  static Future<Response>? getData({
    @required String? url,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer ${userInfo['token']}',
      'Accept': 'application/json',
    };
    bool rConn = await checkConnection();
    if(rConn){
      return await dio!.get(url!);
    }
    throw new UnsupportedError("Connection Internet is invalid");
  }

  static Future<Response>? postData({
    @required String? url,
    @required Map<String, dynamic>? data,
  }) async {
    dio!.options.headers = {
      'Authorization' : 'Bearer ${userInfo['token']}',
      'Accept': 'application/json',
    };
    bool rConn = await checkConnection();

    if(rConn){
      return await dio!.post(url!, data: data);
    }
    throw new UnsupportedError("Connection Internet is invalid");

  }

  static Future<Response>? postDataWithOutToken({
    @required String? url,
    @required Map<String, dynamic>? data,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
    };
    bool rConn = await checkConnection();

    if(rConn){
      return await dio!.post(url!, data: data);
    }
    throw new UnsupportedError("Connection Internet is invalid");

  }


}
