import 'dart:io';

class MangerAd{

  bool _isTestMode = true;


  /// Singleton pattern for init [MangerAd]
  static final MangerAd? _instanc = null;
  MangerAd get instanc {
    if(_instanc == null){
      return MangerAd();
    }
    return MangerAd();
  }


  String get appId {
    if(Platform.isAndroid){
      return "ca-app-pub-3948779118105482~9267949265";
    }else if(Platform.isIOS){
      return "";
    }else{
      throw new UnsupportedError("This Platform is not supported !");
    }
  }

  String get banner {
    if(_isTestMode){
      return "ca-app-pub-3940256099942544/6300978111";
    }else if(Platform.isAndroid){
      return "ca-app-pub-3948779118105482/9977012817";
    }else if(Platform.isIOS){
      return "==";
    }else{
      throw new UnsupportedError("This Platform is not supported !");
    }
  }

  String get popup {
    if(_isTestMode){
      return "ca-app-pub-3940256099942544/1033173712";
    }else if(Platform.isAndroid){
      return "ca-app-pub-3948779118105482/9132217896";
    }else if(Platform.isIOS){
      return "==";
    }else{
      throw new UnsupportedError("This Platform is not supported !");
    }
  }

  String get content {
    if(_isTestMode){
      return "ca-app-pub-3940256099942544/2247696110";
    }else if(Platform.isAndroid){
      return "ca-app-pub-3948779118105482/4113477897";
    }else if(Platform.isIOS){
      return "==";
    }else{
      throw new UnsupportedError("This Platform is not supported !");
    }
  }

}