import 'package:beinmatch/Helpers/DioHelper.dart';

class LoggerHelper{
  static Future<bool> saveLog(Object e) async {
    DioHelper.postData(url: 'log', data: {'body': e});
    return false;
  }
}