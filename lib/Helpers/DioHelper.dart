import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/**
 * ----------------------------------------------------------------
 * 
 * Created A Helper Class to handle all the Dio Requests
 * Using a singleton pattern to make sure that only one instance of Dio is created
 * -----------------------------------------------------------------
 */
class DioHelper {
  static Dio? dio;
  static String urlApi = Config.api_url;
  static BaseOptions options = BaseOptions(
    baseUrl: urlApi,
    connectTimeout: 50000,
    receiveTimeout: 30000,
    receiveDataWhenStatusError: true
  );

  static instanc() {
    dio ??= Dio(options);
    return dio;
  }

  static Future<Response>? getData({
    @required String? url,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer ${SheardHelper.getData("token")}',
      'Accept': 'application/json',
    };
    return await dio!.get(url!);
  }

  static Future<Response>? postData({
    @required String? url,
    @required Map<String, dynamic>? data,
  }) async {
    dio!.options.headers = {
      'Authorization' : 'Bearer ${SheardHelper.getData("token")}',
      'Accept': 'application/json',
    };

    
    return await dio!.post(url!, data: data);
  }


}
