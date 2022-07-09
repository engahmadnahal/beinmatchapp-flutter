import 'package:beinmatch/Helpers/DioHelper.dart';

class LoggerHelper{
  static int sendErrorCount = 0;
  static Future<bool> saveLog(String data) async {
    sendErrorCount++;
    try{
      DioHelper.postData(url: 'log', data: {'body': data});
      return true;
    }catch(e){
      if(sendErrorCount < 3){
        saveLog(data);
      }
    }
    return false;
  }
}